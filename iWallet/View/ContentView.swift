//
//  ContentView.swift
//  iWallet
//
//  Created by Владислав Новошинский on 28.03.2023.
//

import SwiftUI
import RealmSwift

struct ContentView: View {
    @EnvironmentObject var viewModel: SceneViewModel
    @ObservedResults(Category.self) var categories
    @State private var showSettingView: Bool = false
    @State private var showAddTransaction: Bool = false
    @State private var selectedCategoryType: CategoryType = .expense
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: Alignment(horizontal: .trailing, vertical: .bottom)) {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack {
                        HStack {
                            BalanceView(amount: viewModel.balance(), type: "Баланс", icon: "equal.circle", viewBG: Color("colorBalanceBG"), amountBG: Color("colorBalanceText"), typeBG: .gray, iconBG: Color("colorBlue"))
                            Spacer(minLength: 10)
                            BalanceView(amount: viewModel.averageDailyAmount(), type: "Средняя за день", icon: "plusminus.circle", viewBG: Color("colorBalanceBG"), amountBG: Color("colorBalanceText"), typeBG: .gray, iconBG: Color("colorYellow"))
                        }
                        Spacer(minLength: 10)
                        HStack {
                            BalanceView(amount: viewModel.totalIncomes(), type: "Доход", icon: "plus.circle", viewBG: Color("colorBalanceBG"), amountBG: Color("colorBalanceText"), typeBG: .gray, iconBG: Color("colorGreen"))
                            Spacer(minLength: 10)
                            BalanceView(amount: viewModel.totalExpenses(), type: "Расход", icon: "minus.circle", viewBG: Color("colorBalanceBG"), amountBG: Color("colorBalanceText"), typeBG: .gray, iconBG: Color("colorRed"))
                        }
                    }
                    .padding()
                    
                    Picker("Тип", selection: $selectedCategoryType) {
                        ForEach(CategoryType.allCases, id: \.self) { type in
                            Text(type.rawValue)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding(10)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color("colorBalanceBG"))
                    .cornerRadius(10)
                    .padding(.horizontal, 15)
                    
                    
                    VStack(spacing: 0) {
                        // создаем массив транзакций по категориями
                        let categoriesWithTransactionsArray = categoriesWithTransaction(categories: categories)
                        
                        // фильтруем категории по типу
                        let filteredCategoriesArray =  filteredCategories(categories: categoriesWithTransactionsArray, type: selectedCategoryType)
                        
                        ForEach(filteredCategoriesArray, id: \.self) { category in
                                let totalAmount = category.categoryAmount(type: selectedCategoryType)
                                VStack(alignment: .leading, spacing: 0) {
                                    HStack {
                                        HStack {
                                            Divider()
                                                .foregroundColor(Color(category.color))
                                                .frame(width: 5, height: 40)
                                                .background(Color(category.color))
                                        }
                                        
                                        Image(systemName: category.icon)
                                            .font(.system(size: 20))
                                            .foregroundColor(.black)
                                            .frame(width: 30, height: 30)
                                            .background(Color(category.color))
                                            .cornerRadius(5)
                                            .padding(0)
                                        
                                        
                                        Text(category.name)
                                            .font(.headline)
                                            .fontWeight(.light)
                                            .foregroundColor(Color("colorBalanceText"))
                                        
                                        Spacer()
                                        
                                        Text(totalAmount.formattedWithSeparatorAndCurrency())
                                            .font(.headline).bold()
                                    
                                }
                                .padding()
                                .frame(maxWidth: .infinity, maxHeight: 50)
                                .background(Color("colorBalanceBG"))
                                
                                Divider()
                                    .padding(.leading, 70)
                            }
                        }
                    }
                    .cornerRadius(10)
                    .padding(.horizontal, 15)
                }
                
                HStack {
                    Button {
                        showAddTransaction.toggle()
                    } label: {
                        ZStack {
                            Circle()
                                .frame(width: 50, height: 50)
                                .foregroundColor(Color("colorBalanceText"))
                            Image(systemName: "plus")
                                .foregroundColor(Color("colorBG"))
                                .font(.system(size: 25))
                        }
                    }
                }
                .padding()
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            showSettingView.toggle()
                        } label: {
                            Image(systemName: "gearshape.circle")
                                .font(.title3)
                                .foregroundColor(Color("colorBalanceText"))
                        }
                    }
                    ToolbarItem(placement: .navigationBarLeading) {
                        Text("iWallet")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(Color("colorBalanceText"))
                    }
                }
            }
            .background(Color("colorBG"))
        } .fullScreenCover(isPresented: $showSettingView) {
            SettingView()
        }
        .sheet(isPresented: $showAddTransaction) {
            AddTransaction(selectedCategory: Category())
        }
    }
    
    // Функция которая фильтрует список категорий, чтобы найти только те, которые имеют транзакции определенного типа.
    func categoriesWithTransaction(categories: Results<Category>) -> [Category] {
        var result: [Category] = []
        for category in categories {
            if category.hasTransactions(type: selectedCategoryType) {
                result.append(category)
            }
        }
        return result
    }
    // Функция фильтрует категории из массива categories, сохраняя только те, сумма транзакций которых для заданного типа type (доход или расход) больше 0
    func filteredCategories(categories: [Category], type: CategoryType) -> [Category] {
        var result: [Category] = []
        for category in categories {
            if category.categoryAmount(type: type) > 0 {
                result.append(category)
            }
        }
        return result
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = SceneViewModel()
        let cofiguration = Realm.Configuration(inMemoryIdentifier: "Preview")
        
        ContentView()
            .environmentObject(viewModel)
            .environment(\.realmConfiguration, cofiguration)
    }
}
