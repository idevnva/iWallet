//
//  FilterView.swift
//  iWallet
//
//  Created by Vladislav Novoshinskiy on 15.05.2023.
//

import SwiftUI

struct FilterView: View {
    @Binding var showBalance: Bool
    @Binding var showExpenseAverage: Bool
    @Binding var showIncome: Bool
    @Binding var showExpense: Bool
    @Binding var showIncomeAverage: Bool
    @Binding var showTotalCashFlow: Bool
    
    var body: some View {
        Form {
            Toggle(isOn: $showBalance) {
                HStack {
                    Image(systemName: "equal.circle")
                        .foregroundColor(Color("colorBlack"))
                        .frame(width: 30, height: 30)
                        .background(Color("colorBlue"))
                        .cornerRadius(7.5)
                    Text("Balance")
                }
            }
            Toggle(isOn: $showExpenseAverage) {
                HStack {
                    Image(systemName: "plusminus.circle")
                        .foregroundColor(Color("colorBlack"))
                        .frame(width: 30, height: 30)
                        .background(Color("colorYellow"))
                        .cornerRadius(7.5)
                    Text("Expense average")
                }
            }
            Toggle(isOn: $showIncome) {
                HStack {
                    Image(systemName: "plus.circle")
                        .foregroundColor(Color("colorBlack"))
                        .frame(width: 30, height: 30)
                        .background(Color("colorGreen"))
                        .cornerRadius(7.5)
                    Text("Income")
                }
            }
            Toggle(isOn: $showExpense) {
                HStack {
                    Image(systemName: "minus.circle")
                        .foregroundColor(Color("colorBlack"))
                        .frame(width: 30, height: 30)
                        .background(Color("colorRed"))
                        .cornerRadius(7.5)
                    Text("Expense")
                }
            }
            Toggle(isOn: $showIncomeAverage) {
                HStack {
                    Image(systemName: "plus.forwardslash.minus")
                        .foregroundColor(Color("colorBlack"))
                        .frame(width: 30, height: 30)
                        .background(Color("colorPurple"))
                        .cornerRadius(7.5)
                    Text("Income average")
                }
            }
            Toggle(isOn: $showTotalCashFlow) {
                HStack {
                    Image(systemName: "sum")
                        .foregroundColor(Color("colorBlack"))
                        .frame(width: 30, height: 30)
                        .background(Color("colorGray1"))
                        .cornerRadius(7.5)
                    Text("Total turnover")
                }
            }
        }
    }
}

struct FilterView_Previews: PreviewProvider {
    static var previews: some View {
        FilterView(showBalance: .constant(true), showExpenseAverage: .constant(true), showIncome: .constant(true), showExpense: .constant(true), showIncomeAverage: .constant(false), showTotalCashFlow: .constant(false))
    }
}
