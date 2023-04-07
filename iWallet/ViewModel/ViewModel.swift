//  ViewModel.swift

import Foundation
import RealmSwift

final class SceneViewModel: ObservableObject {
    @Published var categories: [Category] = []
    @Published var transactions: [TransactionItem] = []
    
    init() {
        let config = Realm.Configuration(schemaVersion: 13)
        Realm.Configuration.defaultConfiguration = config
        checkFirstRun()
        loadData()
    }
    
    // Метод для загрузки базы
   private func loadData() {
        guard let realm = try? Realm() else {
            print("Ошибка: loadData")
            return
        }

        let categoriesResult = realm.objects(Category.self)
        let transactionsResult = realm.objects(TransactionItem.self)

        categories = Array(categoriesResult)
        transactions = Array(transactionsResult)
    }
}


extension SceneViewModel {
    
    // Метод проверки на первый запуск
    private func checkFirstRun() {
        if UserDefaults.standard.bool(forKey: "hasRunBefore") == false {
            createDefaultCategories()
            UserDefaults.standard.set(true, forKey: "hasRunBefore")
        }
    }
    
    // Добавления категорий по умолчанию
    private func createDefaultCategories() {
        guard let realm = try? Realm() else {
            print("Ошибка: Не удалось создать категории по умолчанию Realm")
            return
        }
        let defaultCategories = [
            // Все категории для расхода
            Category(value: ["name": "Автомобиль", "icon": "car", "color": "colorBlue", "type": CategoryType.expense] as [String : Any]),
            Category(value: ["name": "Банк", "icon": "creditcard", "color": "colorBlue1", "type": CategoryType.expense] as [String : Any]),
            Category(value: ["name": "Бизнес-услуги", "icon": "person.2", "color": "colorBlue2", "type": CategoryType.expense] as [String : Any]),
            Category(value: ["name": "Благотворительность", "icon": "figure.roll", "color": "colorGreen", "type": CategoryType.expense] as [String : Any]),
            Category(value: ["name": "Государство", "icon": "network.badge.shield.half.filled", "color": "colorGreen1", "type": CategoryType.expense] as [String : Any]),
            Category(value: ["name": "Дети", "icon": "figure.2.and.child.holdinghands", "color": "colorGreen2", "type": CategoryType.expense] as [String : Any]),
            Category(value: ["name": "Дом", "icon": "house", "color": "colorYellow", "type": CategoryType.expense] as [String : Any]),
            Category(value: ["name": "Домашние животные", "icon": "fish", "color": "colorYellow1", "type": CategoryType.expense] as [String : Any]),
            Category(value: ["name": "Еда вне дома", "icon": "popcorn", "color": "colorYellow2", "type": CategoryType.expense] as [String : Any]),
            Category(value: ["name": "Здоровье", "icon": "heart", "color": "colorRed", "type": CategoryType.expense] as [String : Any]),
            Category(value: ["name": "Красота", "icon": "fleuron", "color": "colorRed1", "type": CategoryType.expense] as [String : Any]),
            Category(value: ["name": "Мобильная Связь", "icon": "wifi", "color": "colorRed2", "type": CategoryType.expense] as [String : Any]),
            Category(value: ["name": "Образование", "icon": "book", "color": "colorBrown", "type": CategoryType.expense] as [String : Any]),
            Category(value: ["name": "Одежда и обувь", "icon": "backpack", "color": "colorBrown1", "type": CategoryType.expense] as [String : Any]),
            Category(value: ["name": "Подарки", "icon": "gift", "color": "colorBrown2", "type": CategoryType.expense] as [String : Any]),
            Category(value: ["name": "Продукты питания", "icon": "cart", "color": "colorPurple", "type": CategoryType.expense] as [String : Any]),
            Category(value: ["name": "Путешествия", "icon": "airplane", "color": "colorPurple1", "type": CategoryType.expense] as [String : Any]),
            Category(value: ["name": "Развлечения", "icon": "music.mic", "color": "colorPurple2", "type": CategoryType.expense] as [String : Any]),
            Category(value: ["name": "Техника", "icon": "display", "color": "colorGray", "type": CategoryType.expense] as [String : Any]),
            Category(value: ["name": "Транспорт", "icon": "bus.fill", "color": "colorGray1", "type": CategoryType.expense] as [String : Any]),
            
            // Все категории для дохода
            Category(value: ["name": "Аренда", "icon": "key", "color": "colorBlue", "type": CategoryType.income] as [String : Any]),
            Category(value: ["name": "Биржа", "icon": "arrow.triangle.2.circlepath", "color": "colorBlue1", "type": CategoryType.income] as [String : Any]),
            Category(value: ["name": "Дивиденды", "icon": "chart.xyaxis.line", "color": "colorBlue2", "type": CategoryType.income] as [String : Any]),
            Category(value: ["name": "Заработная плата", "icon": "dollarsign", "color": "colorGreen", "type": CategoryType.income] as [String : Any]),
            Category(value: ["name": "Подарки", "icon": "shippingbox.circle", "color": "colorGreen1", "type": CategoryType.income] as [String : Any]),
            Category(value: ["name": "Подработка", "icon": "person.fill.checkmark", "color": "colorGreen2", "type": CategoryType.income] as [String : Any]),
            Category(value: ["name": "Проценты по счетам", "icon": "percent", "color": "colorYellow", "type": CategoryType.income] as [String : Any])
        ]
        try! realm.write {
            for category in defaultCategories {
                realm.add(category)
            }
        }
    }
    
    // Метод сохранения категории
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
            return print("Ошибка сохранения категории: \(error)") // отладочное сообщение
        }
    }
    
    // Метод сохранения транзакции
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
    
    // Метод для удаления категории
    func deleteCategory(id: ObjectId) {
        do {
            let realm = try Realm()
            if let category = realm.object(ofType: Category.self, forPrimaryKey: id) {
                try realm.write {
                    // Удаление всех транзакций, связанных с категорией
                    for transaction in category.transactions {
                        realm.delete(transaction)
                    }

                    // Удаление категории
                    realm.delete(category)
                }
                loadData()
            }
        } catch {
            print("Error deleting category: \(error)")
        }
    }

    // Метод для удаления транзакций
    func deleteTransaction(withId id: ObjectId) {
            do {
                let realm = try Realm()

                if let transaction = realm.object(ofType: TransactionItem.self, forPrimaryKey: id) {
                    try realm.write {
                        if let category = transaction.category.first {
                            if let index = category.transactions.firstIndex(of: transaction) {
                                category.transactions.remove(at: index)
                            }
                        }
                        realm.delete(transaction)
                    }
                    loadData()
                } else {
                    print("Транзакция с ID \(id) не найдена")
                }
            } catch let error {
                print("Ошибка удаления транзакции: \(error)")
            }
        }
    
    // Считает расход
    func totalExpenses() -> Float {
        var expenses: Float = 0
        for transaction in transactions {
            if transaction.type == .expense {
                expenses += transaction.amount
            }
        }
        return expenses
    }
    
    // Считает доход
    func totalIncomes() -> Float {
        var icncome: Float = 0
        for transaction in transactions {
            if transaction.type == .income {
                icncome += transaction.amount
            }
        }
        return icncome
    }
    
    // Считает балланс
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
