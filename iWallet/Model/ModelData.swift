//  ModelData.swift

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

extension Category {
    
    // Функция проверяет, есть ли в категории транзакции с выбранным типом (доход или расход)
    func hasTransactions(type: CategoryType) -> Bool {
        for transaction in transactions {
            if transaction.type == type {
                return true
            }
        }
        return false
    }
    
    // Функция которая вычисляет сумму всех транзакций определенного типа (категории) из списка транзакций.
    func categoryAmount(type: CategoryType) -> Float {
        var totalAmount: Float = 0
        for transaction in transactions {
            if transaction.type == type {
                totalAmount += transaction.amount
            }
        }
        return totalAmount
    }
}

extension Float {
    func formattedWithSeparatorAndCurrency() -> String {
        let formatter = NumberFormatter()
                formatter.numberStyle = .currency
                formatter.locale = Locale.current
                formatter.currencySymbol = Locale.current.currencySymbol
                formatter.groupingSize = 3
                formatter.groupingSeparator = "."
                formatter.maximumFractionDigits = 0

        if Locale.current.currency?.identifier == "RUB" {
                    formatter.currencySymbol = "₽"
                }

        if Locale.current.currency?.identifier == "TMT" {
                    formatter.currencySymbol = "m"
                }

                let formattedNumber = formatter.string(from: NSNumber(value: self)) ?? "\(self)"
                return formattedNumber
    }
}
