//  AddTransaction.swift

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
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading) {
                    Section {
                        TextField("100", text: $amount)
                            .keyboardType(.decimalPad)
                            .padding()
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(Color("colorBalanceBG"))
                            .cornerRadius(10)
                            .padding(.bottom, 15)
                    } header: {
                        Text("Введите сумму:")
                            .font(.caption).textCase(.uppercase)
                            .padding(.leading, 10)
                    }
                    
                    Section {
                        TextField("Заметка", text: $note)
                            .padding()
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(Color("colorBalanceBG"))
                            .cornerRadius(10)
                            .padding(.bottom, 15)
                    } header: {
                        Text("Введите заметку:")
                            .font(.caption).textCase(.uppercase)
                            .padding(.leading, 10)
                    }
                    
                    Section {
                        Picker("Тип категории", selection: $selectedType) {
                            ForEach(CategoryType.allCases, id: \.self) { type in
                                Text(type.rawValue)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .padding()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color("colorBalanceBG"))
                        .cornerRadius(10)
                        
                        HStack {
                            Picker("Категория", selection: $selectedCategory) {
                                ForEach(categories.filter { $0.type == selectedType }, id: \.self) { category in
                                    HStack {
                                        Image(systemName: category.icon)
                                            .foregroundColor(Color(.black))
                                            .frame(width: 30, height: 30)
                                            .background(Color(category.color))
                                            .cornerRadius(7.5)
                                        Text(category.name)
                                            .foregroundColor(Color("colorBalanceText"))
                                    }
                                }
                            }
                            .foregroundColor(Color("colorBalanceText"))
                            .pickerStyle(.navigationLink)
                            .padding()
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(Color("colorBalanceBG"))
                            .cornerRadius(10)
                            .padding(.bottom, 15)
                        }
                    } header: {
                        Text("Назначение:")
                            .font(.caption).textCase(.uppercase)
                            .padding(.leading, 10)
                    }
                    
                    Section {
                        HStack {
                            DatePicker("Дата", selection: $date, displayedComponents: .date)
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .padding()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color("colorBalanceBG"))
                        .cornerRadius(10)
                    } header: {
                        Text("Выберете дату:")
                            .font(.caption).textCase(.uppercase)
                            .padding(.leading, 10)
                    }
                }
                .padding(.horizontal, 15)
                .padding(.top, 20)
                
            }
            .background(Color("colorBG"))
            .navigationBarTitle("Добавление транзакции", displayMode: .inline)
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
                        viewModel.saveTransaction(amount: Float(amount) ?? 0, date: date, note: note, type: selectedType, category: selectedCategory)
                        dismiss()
                    } label: {
                        Image(systemName: "checkmark.circle")
                            .font(.title3)
                            .foregroundColor(Color("colorBalanceText"))
                    }
                }
            }
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
