//
//  ModelData.swift
//  iWallet
//
//  Created by Владислав Новошинский on 29.03.2023.
//

import Foundation
import RealmSwift

class Category: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: ObjectId = ObjectId.generate()
    @Persisted var name: String = ""
    @Persisted var icon: String = ""
    @Persisted var color: String = ""
    @Persisted var type: CategoryType = .expense
    @Persisted var transactions: List<TransactionItem> = List<TransactionItem>()
}

class TransactionItem: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: ObjectId = ObjectId.generate()
    @Persisted var categoryId: ObjectId = ObjectId.generate()
    @Persisted var amount: Float = 0
    @Persisted var note: String = ""
    @Persisted var date: Date = Date()
    @Persisted var type: CategoryType = .expense
    @Persisted(originProperty: "transactions") var category: LinkingObjects<Category>
}

enum CategoryType: String, PersistableEnum, CaseIterable {
    case expense = "Расход"
    case income = "Доход"
}
