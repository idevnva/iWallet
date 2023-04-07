//  TransactionView.swift

import SwiftUI
import RealmSwift

struct TransactionView: View {
    @EnvironmentObject var viewModel: SceneViewModel
    @Environment(\.dismiss) var dismiss
    @ObservedResults(TransactionItem.self) var transactions
    @ObservedResults(Category.self) var categories
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()
    
    var body: some View {
        NavigationStack {
            List {
                if transactions.isEmpty {
                    VStack(alignment: .center) {
                        Spacer(minLength: 20)
                        Image("icon")
                            .resizable()
                            .frame(width: 25, height: 25)
                        Spacer()
                        Text("iWallet")
                            .foregroundColor(.gray).bold()
                            .font(.title)
                        Text("Добро пожаловать!")
                            .foregroundColor(.gray)
                        Spacer(minLength: 20)
                        
                        Text("Список транзакций пока, что пуст.")
                            .foregroundColor(.gray)
                            .font(.system(size: 12))
                        Text("Пожалуйста добавьте транзакцию.")
                            .foregroundColor(.gray)
                            .font(.system(size: 12))
                        Spacer(minLength: 20)
                }
                .frame(maxWidth: .infinity, maxHeight: 300)
                    
                } else {
                    
                    ForEach(transactions.reversed(), id: \.self) { transaction in
                        let matchingCategories = categories.filter { $0.id == transaction.categoryId }
                        if let category = matchingCategories.first {
                            transactionRow(transaction: transaction, category: category)
                        }
                    }
                    .onDelete(perform: deleteTransaction)
                }
            }
            .navigationBarTitle("Транзакции", displayMode: .inline)
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
            }
        }
    }
    
    private func transactionRow(transaction: TransactionItem, category: Category) -> some View {
         VStack(alignment: .leading, spacing: 0) {
             HStack {
                 HStack {
                     Divider()
                         .foregroundColor(Color(category.color))
                         .frame(width: 5, height: 150)
                         .background(Color(category.color))
                 } .padding(.trailing, 3)
                 
                 VStack(alignment: .leading) {
                     HStack {
                         Text(transaction.amount.formattedWithSeparatorAndCurrency())
                             .font(.title3).bold()
                         Spacer()
                         HStack {
                             Text(category.name)
                                 .foregroundColor(Color("colorBalanceText")).textCase(.uppercase)
                                 .font(.caption)
                                 .multilineTextAlignment(.trailing)
                                 .dynamicTypeSize(.small)
                                 .padding(0)
                             Image(systemName: category.icon)
                                 .font(.caption).dynamicTypeSize(.small)
                                 .foregroundColor(.black)
                                 .frame(width: 20, height: 20)
                                 .background(Color(category.color))
                                 .cornerRadius(5)
                                 .padding(0)
                         } .padding(0)
                     }
                     Text(transaction.note)
                         .foregroundColor(Color(.gray)).textCase(.uppercase)
                         .font(.subheadline).dynamicTypeSize(.small)
                 }    .padding(.leading, 10)
             }
         }
         .padding(.vertical, 5)
         .frame(height: 50)
     }
    
    private func deleteTransaction(at offsets: IndexSet) {
        offsets.forEach { index in
            let transaction = transactions.reversed()[index]
            viewModel.deleteTransaction(withId: transaction.id)
        }
    }
}

struct TransactionView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionView()
            .environmentObject(SceneViewModel())
    }
}
