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
        let config = Realm.Configuration(schemaVersion: 2)
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
}


//нужно сделать метод удаления категории
//
//import Foundation
//import RealmSwift
//
//class Category: Object, ObjectKeyIdentifiable {
//    @Persisted(primaryKey: true) var id: ObjectId = ObjectId.generate()
//    @Persisted var name: String = ""
//    @Persisted var icon: String = ""
//    @Persisted var color: String = ""
//    @Persisted var type: CategoryType = .expense
//    @Persisted var transactions: List<TransactionItem> = List<TransactionItem>()
//}
//
//enum CategoryType: String, PersistableEnum, CaseIterable {
//    case expense = "Расход"
//    case income = "Доход"
//}
//
////
////  ViewModel.swift
////  iWallet
////
////  Created by Владислав Новошинский on 29.03.2023.
////
//
//import Foundation
//import RealmSwift
//
//class SceneViewModel: ObservableObject {
//    @Published var categories: [Category] = []
//    @Published var transactions: [TransactionItem] = []
//
//    init() {
//        let config = Realm.Configuration(schemaVersion: 2)
//        Realm.Configuration.defaultConfiguration = config
//        checkFirstRun()
//        loadData()
//    }
//
//    func checkFirstRun() {
//        if UserDefaults.standard.bool(forKey: "hasRunBefore") == false {
//            createDefaultCategories()
//            UserDefaults.standard.set(true, forKey: "hasRunBefore")
//        }
//    }
//
//    func createDefaultCategories() {
//        guard let realm = try? Realm() else {
//            print("Ошибка: Не удалось создать категории по умолчанию Realm")
//            return
//        }
//
//        let defaultCategories = [
//            Category(value: ["name": "Продукты", "icon": "snowflake.circle", "color": "colorBlue1", "type": CategoryType.expense]),
//            Category(value: ["name": "Семья", "icon": "heart.circle", "color": "colorRed1", "type": CategoryType.expense]),
//            Category(value: ["name": "Зарплата", "icon": "star.circle", "color": "colorGreen1", "type": CategoryType.income]),
//            Category(value: ["name": "Премия", "icon": "bookmark.circle", "color": "colorYellow1", "type": CategoryType.income])
//        ]
//
//        try! realm.write {
//            for category in defaultCategories {
//                realm.add(category)
//            }
//        }
//    }
//
//    func saveCategory(name: String, icon: String, color: String, type: CategoryType) {
//        guard let realm = try? Realm() else {
//            print("Ошибка: Не удалось создать экземпляр Realm")
//            return
//        }
//        let newCategory = Category()
//        newCategory.name = name
//        newCategory.icon = icon
//        newCategory.color = color
//        newCategory.type = type
//        do {
//            try realm.write {
//                realm.add(newCategory)
//            }
//            return print("Категория сохранена: \(newCategory)") // отладочное сообщение
//        } catch {
//            return print("Ошибка сохранения категории: \(error)")
//        }
//    }
//
//    func loadData() {
//        guard let realm = try? Realm() else {
//            print("Ошибка: loadData")
//            return
//        }
//
//        let categoriesResult = realm.objects(Category.self)
//        let transactionsResult = realm.objects(TransactionItem.self)
//
//        categories = Array(categoriesResult)
//        transactions = Array(transactionsResult)
//    }
//}
