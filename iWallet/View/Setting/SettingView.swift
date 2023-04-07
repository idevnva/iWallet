//  SettingView.swift

import SwiftUI

struct SettingView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.openURL) var openURL
    
    @State var showCategory: Bool = false
    @State var showTransactionView: Bool = false
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    Button {
                        showTransactionView.toggle()
                    } label: {
                        HStack {
                            Image(systemName: "clock.circle")
                                .foregroundColor(Color("colorBlack"))
                                .frame(width: 30, height: 30)
                                .background(Color("colorYellow"))
                                .cornerRadius(7.5)
                            Text("Транзакции")
                                .foregroundColor(Color("colorBalanceText"))
                            Spacer()
                            Image(systemName: "chevron.forward")
                                .foregroundColor(Color("colorBalanceText"))
                                .opacity(0.5)
                        }
                    }
                    
                    Button {
                        showCategory.toggle()
                    } label: {
                        HStack {
                            Image(systemName: "list.bullet.circle")
                                .foregroundColor(Color("colorBlack"))
                                .frame(width: 30, height: 30)
                                .background(Color("colorBlue"))
                                .cornerRadius(7.5)
                            Text("Категории")
                                .foregroundColor(Color("colorBalanceText"))
                            Spacer()
                            Image(systemName: "chevron.forward")
                                .foregroundColor(Color("colorBalanceText"))
                                .opacity(0.5)
                        }
                    }
                } header: {
                    Text("Данные")
                }
                
                Section {
                    Button {
                        openURL(URL(string: "https://t.me/idevnva")!)
                    } label: {
                        HStack {
                            Image(systemName: "envelope.circle")
                                .foregroundColor(Color("colorBlack"))
                                .frame(width: 30, height: 30)
                                .background(Color("colorGray1"))
                                .cornerRadius(7.5)
                            Text("Написать разработчику")
                                .foregroundColor(Color("colorBalanceText"))
                            Spacer()
                            Image(systemName: "chevron.forward")
                                .foregroundColor(Color("colorBalanceText"))
                                .opacity(0.5)
                        }
                    }
                    
                } header: {
                    Text("Обратная связь")
                }
            }
            .background(Color("colorBG"))
            .scrollContentBackground(.hidden)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark.circle")
                            .font(.title3)
                            .foregroundColor(Color("colorBalanceText"))
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("Настройки")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(Color("colorBalanceText"))
                }
            }
        }
        .fullScreenCover(isPresented: $showCategory) {
            CategoryView()
        }
        .sheet(isPresented: $showTransactionView) {
            TransactionView()
        }
    }
}


struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
