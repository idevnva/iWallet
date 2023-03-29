//
//  AddCategoryView.swift
//  iWallet
//
//  Created by Владислав Новошинский on 28.03.2023.
//

import SwiftUI
import RealmSwift

struct CategoryView: View {
    @EnvironmentObject var viewModel: SceneViewModel
    @Environment(\.dismiss) var dismiss
    @ObservedResults(Category.self) var categories
    @State private var selectedType: CategoryType = .expense
    @State var showAddCategory: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(categories, id: \.self) { category in
                        HStack {
                            Image(systemName: category.icon)
                                .foregroundColor(Color(.black))
                                .frame(width: 30, height: 30)
                                .background(Color(category.color))
                                .cornerRadius(10)
                            Text(category.name)
                                .foregroundColor(Color("colorBalanceText"))
                        }
                    }
                }
                .background(Color("colorBG"))
                .scrollContentBackground(.hidden)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark.circle")
                            .font(.title3)
                            .foregroundColor(Color("colorBalanceText"))
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showAddCategory.toggle()
                    } label: {
                        Image(systemName: "square.and.pencil.circle")
                            .font(.title3)
                            .foregroundColor(Color("colorBalanceText"))
                    }
                }
                ToolbarItem(placement: .principal) {
                    Picker("Type", selection: $selectedType) {
                        Text("Расход").tag(CategoryType.expense)
                        Text("Доход").tag(CategoryType.income)
                    } .pickerStyle(.segmented)
                }
            }
        }
        .sheet(isPresented: $showAddCategory) {
            AddCategory()
        }
    }
}

struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = SceneViewModel()
        let cofiguration = Realm.Configuration(inMemoryIdentifier: "Preview")
        
        CategoryView()
            .environmentObject(viewModel)
            .environment(\.realmConfiguration, cofiguration)
    }
}
