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
    case expense = "Expense"
    case income = "Income"
    
    func localizedName() -> String {
        return NSLocalizedString(self.rawValue, comment: "")
    }
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

// метод возвращает сумму с точками после каждых трех символов
extension Float {
    func formattedWithSeparatorAndCurrency() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSize = 3
        formatter.groupingSeparator = "."
        formatter.maximumFractionDigits = 0
        
        let formattedNumber = formatter.string(from: NSNumber(value: self)) ?? "\(self)"
        return formattedNumber
    }
}

enum Currency: String, CaseIterable, Identifiable, Hashable {
    case usd = "USD"
    case eur = "EUR"
    case rub = "RUB"
    case tmt = "TMT"
    case byn = "BYN"
    case TRY = "TRY"
    case kzt = "KZT"
    case uah = "UAH"
    case cny = "CNY"
    case gbp = "GBP"
    
    var id: String {
        return self.rawValue
    }
    
    var symbol: String {
        switch self {
        case .usd:
            return "$"
        case .eur:
            return "€"
        case .rub:
            return "₽"
        case .tmt:
            return "m"
        case .byn:
            return "Br"
        case .TRY:
            return "₺"
        case .kzt:
            return "₸"
        case .uah:
            return "₴"
        case .cny:
            return "¥"
        case .gbp:
            return "£"
        }
    }
    
    static var sortedCases: [Currency] {
        return Currency.allCases.sorted(by: { $0.rawValue < $1.rawValue })
    }
}
