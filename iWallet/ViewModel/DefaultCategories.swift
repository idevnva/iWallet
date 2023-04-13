//
//  DefaultCategories.swift
//  iWallet
//
//  Created by Владислав Новошинский on 13.04.2023.
//

import Foundation
import RealmSwift

let deviceLanguage = Locale.current.language.languageCode?.identifier

let defaultCategories = {
    switch deviceLanguage {
    case "ru":
        return [
            // Все категории для расхода
            Category(value: ["name": NSLocalizedString("Автомобиль", comment: "Автомобиль"), "icon": "car", "color": "colorBlue", "type": CategoryType.expense] as [String : Any]),
            Category(value: ["name": NSLocalizedString("Банк", comment: "Банк"), "icon": "creditcard", "color": "colorBlue1", "type": CategoryType.expense] as [String : Any]),
            Category(value: ["name": NSLocalizedString("Бизнес-услуги", comment: "Бизнес-услуги"), "icon": "person.2", "color": "colorBlue2", "type": CategoryType.expense] as [String : Any]),
            Category(value: ["name": NSLocalizedString("Благотворительность", comment: "Благотворительность"), "icon": "figure.roll", "color": "colorGreen", "type": CategoryType.expense] as [String : Any]),
            Category(value: ["name": NSLocalizedString("Государство", comment: "Государство"), "icon": "network.badge.shield.half.filled", "color": "colorGreen1", "type": CategoryType.expense] as [String : Any]),
            Category(value: ["name": NSLocalizedString("Дети", comment: "Дети"), "icon": "figure.2.and.child.holdinghands", "color": "colorGreen2", "type": CategoryType.expense] as [String : Any]),
            Category(value: ["name": NSLocalizedString("Дом", comment: "Дом"), "icon": "house", "color": "colorYellow", "type": CategoryType.expense] as [String : Any]),
            Category(value: ["name": NSLocalizedString("Домашние животные", comment: "Домашние животные"), "icon": "fish", "color": "colorYellow1", "type": CategoryType.expense] as [String : Any]),
            Category(value: ["name": NSLocalizedString("Еда вне дома", comment: "Еда вне дома"), "icon": "popcorn", "color": "colorYellow2", "type": CategoryType.expense] as [String : Any]),
            Category(value: ["name": NSLocalizedString("Здоровье", comment: "Здоровье"), "icon": "heart", "color": "colorRed", "type": CategoryType.expense] as [String : Any]),
            Category(value: ["name": NSLocalizedString("Красота", comment: "Красота"), "icon": "fleuron", "color": "colorRed1", "type": CategoryType.expense] as [String : Any]),
            Category(value: ["name": NSLocalizedString("Мобильная Связь", comment: "Мобильная Связь"), "icon": "wifi", "color": "colorRed2", "type": CategoryType.expense] as [String : Any]),
            Category(value: ["name": NSLocalizedString("Образование", comment: "Образование"), "icon": "book", "color": "colorBrown", "type": CategoryType.expense] as [String : Any]),
            Category(value: ["name": NSLocalizedString("Одежда и обувь", comment: "Одежда и обувь"), "icon": "backpack", "color": "colorBrown1", "type": CategoryType.expense] as [String : Any]),
            Category(value: ["name": NSLocalizedString("Подарки", comment: "Подарки"), "icon": "gift", "color": "colorBrown2", "type": CategoryType.expense] as [String : Any]),
            Category(value: ["name": NSLocalizedString("Продукты питания", comment: "Продукты питания"), "icon": "cart", "color": "colorPurple", "type": CategoryType.expense] as [String : Any]),
            Category(value: ["name": NSLocalizedString("Путешествия", comment: "Путешествия"), "icon": "airplane", "color": "colorPurple1", "type": CategoryType.expense] as [String : Any]),
            Category(value: ["name": NSLocalizedString("Развлечения", comment: "Развлечения"), "icon": "music.mic", "color": "colorPurple2", "type": CategoryType.expense] as [String : Any]),
            Category(value: ["name": NSLocalizedString("Техника", comment: "Техника"), "icon": "display", "color": "colorGray", "type": CategoryType.expense] as [String : Any]),
            Category(value: ["name": NSLocalizedString("Транспорт", comment: "Транспорт"), "icon": "bus.fill", "color": "colorGray1", "type": CategoryType.expense] as [String : Any]),
            
            // Все категории для дохода
            Category(value: ["name": NSLocalizedString("Аренда", comment: "Аренда"), "icon": "key", "color": "colorBlue", "type": CategoryType.income] as [String : Any]),
            Category(value: ["name": NSLocalizedString("Биржа", comment: "Биржа"), "icon": "arrow.triangle.2.circlepath", "color": "colorBlue1", "type": CategoryType.income] as [String : Any]),
            Category(value: ["name": NSLocalizedString("Дивиденды", comment: "Дивиденды"), "icon": "chart.xyaxis.line", "color": "colorBlue2", "type": CategoryType.income] as [String : Any]),
            Category(value: ["name": NSLocalizedString("Заработная плата", comment: "Заработная плата"), "icon": "dollarsign", "color": "colorGreen", "type": CategoryType.income] as [String : Any]),
            Category(value: ["name": NSLocalizedString("Подарки", comment: "Подарки"), "icon": "shippingbox.circle", "color": "colorGreen1", "type": CategoryType.income] as [String : Any]),
            Category(value: ["name": NSLocalizedString("Подработка", comment: "Подработка"), "icon": "person.fill.checkmark", "color": "colorGreen2", "type": CategoryType.income] as [String : Any]),
            Category(value: ["name": NSLocalizedString("Проценты по счетам", comment: "Проценты по счетам"), "icon": "percent", "color": "colorYellow", "type": CategoryType.income] as [String : Any])
        ]
        
    default:
        return [
            // Все категории для расхода
            Category(value: ["name": NSLocalizedString("Car", comment: "Car"), "icon": "car", "color": "colorBlue", "type": CategoryType.expense] as [String : Any]),
            Category(value: ["name": NSLocalizedString("Bank", comment: "Bank"), "icon": "creditcard", "color": "colorBlue1", "type": CategoryType.expense] as [String : Any]),
            Category(value: ["name": NSLocalizedString("Business services", comment: "Business services"), "icon": "person.2", "color": "colorBlue2", "type": CategoryType.expense] as [String : Any]),
            Category(value: ["name": NSLocalizedString("Charity", comment: "Charity"), "icon": "figure.roll", "color": "colorGreen", "type": CategoryType.expense] as [String : Any]),
            Category(value: ["name": NSLocalizedString("State", comment: "State"), "icon": "network.badge.shield.half.filled", "color": "colorGreen1", "type": CategoryType.expense] as [String : Any]),
            Category(value: ["name": NSLocalizedString("Children", comment: "Children"), "icon": "figure.2.and.child.holdinghands", "color": "colorGreen2", "type": CategoryType.expense] as [String : Any]),
            Category(value: ["name": NSLocalizedString("House", comment: "House"), "icon": "house", "color": "colorYellow", "type": CategoryType.expense] as [String : Any]),
            Category(value: ["name": NSLocalizedString("Pets", comment: "Pets"), "icon": "fish", "color": "colorYellow1", "type": CategoryType.expense] as [String : Any]),
            Category(value: ["name": NSLocalizedString("Eating out", comment: "Eating out"), "icon": "popcorn", "color": "colorYellow2", "type": CategoryType.expense] as [String : Any]),
            Category(value: ["name": NSLocalizedString("Health", comment: "Health"), "icon": "heart", "color": "colorRed", "type": CategoryType.expense] as [String : Any]),
            Category(value: ["name": NSLocalizedString("Beauty", comment: "Beauty"), "icon": "fleuron", "color": "colorRed1", "type": CategoryType.expense] as [String : Any]),
            Category(value: ["name": NSLocalizedString("Mobile connection", comment: "Mobile connection"), "icon": "wifi", "color": "colorRed2", "type": CategoryType.expense] as [String : Any]),
            Category(value: ["name": NSLocalizedString("Education", comment: "Education"), "icon": "book", "color": "colorBrown", "type": CategoryType.expense] as [String : Any]),
            Category(value: ["name": NSLocalizedString("Clothing and footwear", comment: "Clothing and footwear"), "icon": "backpack", "color": "colorBrown1", "type": CategoryType.expense] as [String : Any]),
            Category(value: ["name": NSLocalizedString("Present", comment: "Present"), "icon": "gift", "color": "colorBrown2", "type": CategoryType.expense] as [String : Any]),
            Category(value: ["name": NSLocalizedString("Food", comment: "Food"), "icon": "cart", "color": "colorPurple", "type": CategoryType.expense] as [String : Any]),
            Category(value: ["name": NSLocalizedString("Trips", comment: "Trips"), "icon": "airplane", "color": "colorPurple1", "type": CategoryType.expense] as [String : Any]),
            Category(value: ["name": NSLocalizedString("Entertainment", comment: "Entertainment"), "icon": "music.mic", "color": "colorPurple2", "type": CategoryType.expense] as [String : Any]),
            Category(value: ["name": NSLocalizedString("Technique", comment: "Technique"), "icon": "display", "color": "colorGray", "type": CategoryType.expense] as [String : Any]),
            Category(value: ["name": NSLocalizedString("Transport", comment: "Transport"), "icon": "bus.fill", "color": "colorGray1", "type": CategoryType.expense] as [String : Any]),
            
            // Все категории для дохода
            Category(value: ["name": NSLocalizedString("Rent", comment: "Rent"), "icon": "key", "color": "colorBlue", "type": CategoryType.income] as [String : Any]),
            Category(value: ["name": NSLocalizedString("Exchange", comment: "Exchange"), "icon": "arrow.triangle.2.circlepath", "color": "colorBlue1", "type": CategoryType.income] as [String : Any]),
            Category(value: ["name": NSLocalizedString("Dividends", comment: "Dividends"), "icon": "chart.xyaxis.line", "color": "colorBlue2", "type": CategoryType.income] as [String : Any]),
            Category(value: ["name": NSLocalizedString("Wage", comment: "Wage"), "icon": "dollarsign", "color": "colorGreen", "type": CategoryType.income] as [String : Any]),
            Category(value: ["name": NSLocalizedString("Present", comment: "Present"), "icon": "shippingbox.circle", "color": "colorGreen1", "type": CategoryType.income] as [String : Any]),
            Category(value: ["name": NSLocalizedString("Part time job", comment: "Part time job"), "icon": "person.fill.checkmark", "color": "colorGreen2", "type": CategoryType.income] as [String : Any]),
            Category(value: ["name": NSLocalizedString("Interest on accounts", comment: "Interest on accounts"), "icon": "percent", "color": "colorYellow", "type": CategoryType.income] as [String : Any])
        ]
    }
}()
