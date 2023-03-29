//
//  AddTransaction.swift
//  iWallet
//
//  Created by Владислав Новошинский on 29.03.2023.
//

import SwiftUI
import RealmSwift

struct AddTransaction: View {
    @EnvironmentObject var viewModel: SceneViewModel
    @Environment(\.dismiss) var dismiss
    @ObservedResults(Category.self) var categories
    @State var selectedCategory: Category
    @State var amount: String = ""
    @State var date: Date = Date()
    @State var note: String = ""
    @State var selectedType: CategoryType = .expense
    @State var showCategoryPicker: Bool = false
    
    var filteredCategories: [Category] {
        return categories.filter { $0.type == selectedType }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                TextField("100", text: $amount)
                
                Picker("Тип категории", selection: $selectedType) {
                    ForEach(CategoryType.allCases, id: \.self) { type in
                        Text(type.rawValue)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                
                Button {
                    showCategoryPicker.toggle()
                } label: {
                    HStack {
                        Image(systemName: selectedCategory.icon)
                            .foregroundColor(Color(.black))
                            .frame(width: 30, height: 30)
                            .background(Color(selectedCategory.color))
                            .cornerRadius(10)
                        if showCategoryPicker != selectedCategory.name.isEmpty {
                            Text("Выбирете категорию")
                            
                        } else {
                            Text(selectedCategory.name)
                                .foregroundColor(Color("colorBalanceText"))
                            Spacer()
                            Image(systemName: "chevron.forward")
                                .foregroundColor(Color("colorBalanceText"))
                                .opacity(0.5)
                        }
                       
                    }

                }
                    
                
                
                
                
                
                
                //                Picker("Категория", selection: $category) {
                //
                //                        ForEach(filteredCategories, id: \.self) { category in
                //                            ScrollView {
                //                            HStack {
                //                                Image(systemName: category.icon)
                ////                                    .foregroundColor(Color(.black))
                ////                                    .frame(width: 30, height: 30)
                ////                                    .background(Color(category.color))
                ////                                    .cornerRadius(10)
                //                                Text(category.name)
                //                                   // .foregroundColor(Color("colorBalanceText"))
                //                              //  Spacer()
                //                               // Image(systemName: "chevron.forward")
                ////                                    .foregroundColor(Color("colorBalanceText"))
                ////                                    .opacity(0.5)
                //                            }
                //                        }
                //                    }
                //                }
            }
        } .sheet(isPresented: $showCategoryPicker) {
            CategoryPicker(selectedCategory: $selectedCategory)
        }
    }
}

struct AddTransaction_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = SceneViewModel()
        let cofiguration = Realm.Configuration(inMemoryIdentifier: "Preview")
        
        AddTransaction(selectedCategory: Category())
            .environmentObject(viewModel)
            .environment(\.realmConfiguration, cofiguration)
    }
}
