//
//  ViewModel.swift
//  iWallet
//
//  Created by Владислав Новошинский on 29.03.2023.
//

import Foundation
import RealmSwift

class SceneViewModel: ObservableObject {
    @Published var categories: [Category] = []
    @Published var transactions: [TransactionItem] = []
    
    init() {
        let config = Realm.Configuration(schemaVersion: 13)
        Realm.Configuration.defaultConfiguration = config
        checkFirstRun()
        loadData()
    }
    
    func checkFirstRun() {
        if UserDefaults.standard.bool(forKey: "hasRunBefore") == false {
            createDefaultCategories()
            UserDefaults.standard.set(true, forKey: "hasRunBefore")
        }
    }
    
    func createDefaultCategories() {
        guard let realm = try? Realm() else {
            print("Ошибка: Не удалось создать категории по умолчанию Realm")
            return
        }
        
        let defaultCategories = [
            Category(value: ["name": "Продукты", "icon": "snowflake.circle", "color": "colorBlue1", "type": CategoryType.expense]),
            Category(value: ["name": "Семья", "icon": "heart.circle", "color": "colorRed1", "type": CategoryType.expense]),
            Category(value: ["name": "Зарплата", "icon": "star.circle", "color": "colorGreen1", "type": CategoryType.income]),
            Category(value: ["name": "Премия", "icon": "bookmark.circle", "color": "colorYellow1", "type": CategoryType.income])
        ]
        
        try! realm.write {
            for category in defaultCategories {
                realm.add(category)
            }
        }
    }
    
    func saveCategory(name: String, icon: String, color: String, type: CategoryType) {
        guard let realm = try? Realm() else {
            print("Ошибка: Не удалось создать экземпляр Realm")
            return
        }
        let newCategory = Category()
        newCategory.name = name
        newCategory.icon = icon
        newCategory.color = color
        newCategory.type = type
        do {
            try realm.write {
                realm.add(newCategory)
            }
            return print("Категория сохранена: \(newCategory)") // отладочное сообщение
        } catch {
            return print("Ошибка сохранения категории: \(error)")
        }
    }

    func loadData() {
        guard let realm = try? Realm() else {
            print("Ошибка: loadData")
            return
        }
        
        let categoriesResult = realm.objects(Category.self)
        let transactionsResult = realm.objects(TransactionItem.self)
        
        categories = Array(categoriesResult)
        transactions = Array(transactionsResult)
    }
    
    func saveTransaction(amount: Float, date: Date, note: String, type: CategoryType, category: Category) {
        guard let realm = try? Realm() else {
            print("Ошибка: Не удалось создать экземпляр Realm")
            return
        }
        if let newCategory = realm.object(ofType: Category.self, forPrimaryKey: category.id) {
            let newTransaction = TransactionItem()
            newTransaction.categoryId = newCategory.id
            newTransaction.amount = amount
            newTransaction.date = date
            newTransaction.note = note
            newTransaction.type = type
            do {
                try realm.write {
                    newCategory.transactions.append(newTransaction)
                }
                transactions.append(newTransaction) // Обновите список транзакций после сохранения
                print("Транзакция сохранена: \(newTransaction)") // Отладочное сообщение
            } catch {
                print("Ошибка сохранения транзакции: \(error)")
            }
        } else {
            print("Ошибка: категория не найдена") // Отладочное сообщение, если категория не найдена
        }
    }
    
    func totalExpenses() -> Float {
        var expenses: Float = 0
        for transaction in transactions {
            if transaction.type == .expense {
                expenses += transaction.amount
            }
        }
        return expenses
    }
    
    func totalIncomes() -> Float {
        var icncome: Float = 0
        for transaction in transactions {
            if transaction.type == .income {
                icncome += transaction.amount
            }
        }
        return icncome
    }
    
    func balance() -> Float {
        return totalIncomes() - totalExpenses()
    }
    
    // Для расчета средней суммы за день, сначала найдем общее количество дней между самой ранней и самой поздней транзакцией, а затем разделим общую сумму транзакций на количество дней
    func averageDailyAmount() -> Float {
        guard let earliestTransaction = transactions.min(by: { $0.date < $1.date }),
              let latestTransaction = transactions.max(by: { $0.date < $1.date }) else {
            return 0
        }
        
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: earliestTransaction.date, to: latestTransaction.date)
        guard let days = components.day, days > 0 else {
            return 0
        }
        
        let totalAmount = transactions.reduce(0) { (result, transaction) -> Float in
            return result + transaction.amount
        }
        
        return totalAmount / Float(days)
    }
    
}
