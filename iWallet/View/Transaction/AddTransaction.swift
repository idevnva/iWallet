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
    @State var alertAmount: Bool = false
    
    private let enterAmountLocalized: LocalizedStringKey = "Enter amount:"
    private let noteLocalized: LocalizedStringKey = "Note"
    private let enterNoteLocalized: LocalizedStringKey = "Enter note:"
    private let categoryTypeLocalized: LocalizedStringKey = "Category type"
    private let categoryLocalized: LocalizedStringKey = "Category"
    private let purposeLocalized: LocalizedStringKey = "Purpose:"
    private let dateLocalized: LocalizedStringKey = "Date"
    private let enterDateLocalized: LocalizedStringKey = "Enter date:"
    private let cancelLocalized: LocalizedStringKey = "Cancel"
    private let addLocalized: LocalizedStringKey = "Add"
    private let pleaseEnterAmountLocalized: LocalizedStringKey = "Please enter amount"
    private let okayLocalized: LocalizedStringKey = "Okay"
    
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
                        Text(enterAmountLocalized)
                            .font(.caption).textCase(.uppercase)
                            .padding(.leading, 10)
                    }
                    
                    Section {
                        TextField(noteLocalized, text: $note)
                            .padding()
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(Color("colorBalanceBG"))
                            .cornerRadius(10)
                            .padding(.bottom, 15)
                    } header: {
                        Text(enterNoteLocalized)
                            .font(.caption).textCase(.uppercase)
                            .padding(.leading, 10)
                    }
                    
                    Section {
                        Picker(categoryTypeLocalized, selection: $selectedType) {
                            ForEach(CategoryType.allCases, id: \.self) { type in
                                Text(type.localizedName)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .padding()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color("colorBalanceBG"))
                        .cornerRadius(10)
                        
                        HStack {
                            Picker(categoryLocalized, selection: $selectedCategory) {
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
                        Text(purposeLocalized)
                            .font(.caption).textCase(.uppercase)
                            .padding(.leading, 10)
                    }
                    Section {
                        HStack {
                            DatePicker(dateLocalized, selection: $date, displayedComponents: .date)
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .padding()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color("colorBalanceBG"))
                        .cornerRadius(10)
                    } header: {
                        Text(enterDateLocalized)
                            .font(.caption).textCase(.uppercase)
                            .padding(.leading, 10)
                    }
                }
                .padding(.horizontal, 15)
                .padding(.top, 20)
                
            }
            .background(Color("colorBG"))
            .navigationBarTitle("", displayMode: .inline)
            
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Text(cancelLocalized)
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        if amount.isEmpty {
                            alertAmount = true
                        } else {
                            viewModel.saveTransaction(amount: Float(amount) ?? 0, date: date, note: note, type: selectedType, category: selectedCategory)
                            dismiss()
                        }
                    } label: {
                        Text(addLocalized)
                    }
                    .alert(pleaseEnterAmountLocalized, isPresented: $alertAmount) {
                        Button(okayLocalized, role: .cancel) { }
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
