//
//  CategoryPicker.swift
//  iWallet
//
//  Created by Владислав Новошинский on 29.03.2023.
//

import SwiftUI
import RealmSwift

struct CategoryPicker: View {
    @Environment(\.dismiss) var dismiss
    @ObservedResults(Category.self) var categories
    @Binding var selectedCategory: Category
    @State var selectedType: CategoryType = .expense
   
    
//    var filteredCategories: [Category] {
//        return categories.filter { $0.type == selectedType }
//    }
    
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(categories.filter { $0.type == selectedType }, id: \.self) { category in
                        HStack {
                            Image(systemName: category.icon)
                                .foregroundColor(Color(.black))
                                .frame(width: 30, height: 30)
                                .background(Color(category.color))
                                .cornerRadius(10)
                            Text(category.name)
                                .foregroundColor(Color("colorBalanceText"))
                            Spacer()
                        }
                        .opacity(category == selectedCategory ? 1.0 : 0.5)
                        .scaleEffect(category == selectedCategory ? 1.1 : 1.0)
                        .onTapGesture {
                            selectedCategory = category
                            dismiss()
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

                ToolbarItem(placement: .principal) {
                    Picker("Type", selection: $selectedType) {
                        ForEach(CategoryType.allCases, id: \.self) { type in
                            Text(type.rawValue).tag(type)
                        }
                    } .pickerStyle(.segmented)
                }
            }
        } 
    }
}

struct CategoryPicker_Previews: PreviewProvider {
    static var previews: some View {
        CategoryPicker(selectedCategory: .constant(Category()))
    }
}
