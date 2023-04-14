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
                            Text("Transactions")
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
                            Text("Categories")
                                .foregroundColor(Color("colorBalanceText"))
                            Spacer()
                            Image(systemName: "chevron.forward")
                                .foregroundColor(Color("colorBalanceText"))
                                .opacity(0.5)
                        }
                    }
                } header: {
                    Text("Data")
                }
                
                Section {
                    
                    Button {
                        openURL(URL(string: "https://idevnva.com/")!)
                    } label: {
                        HStack {
                            Image(systemName: "network")
                                .foregroundColor(Color("colorBlack"))
                                .frame(width: 30, height: 30)
                                .background(Color("colorRed"))
                                .cornerRadius(7.5)
                            Text("Web-site")
                                .foregroundColor(Color("colorBalanceText"))
                            Spacer()
                            Image(systemName: "chevron.forward")
                                .foregroundColor(Color("colorBalanceText"))
                                .opacity(0.5)
                        }
                    }
                    
                    Button {
                        openURL(URL(string: "https://t.me/iwalletapp")!)
                    } label: {
                        HStack {
                            Image(systemName: "person.2.circle")
                                .foregroundColor(Color("colorBlack"))
                                .frame(width: 30, height: 30)
                                .background(Color("colorGreen"))
                                .cornerRadius(7.5)
                            Text("Community")
                                .foregroundColor(Color("colorBalanceText"))
                            Spacer()
                            Image(systemName: "chevron.forward")
                                .foregroundColor(Color("colorBalanceText"))
                                .opacity(0.5)
                        }
                    }
                    
                    Button {
                        openURL(URL(string: "https://t.me/idevnva")!)
                    } label: {
                        HStack {
                            Image(systemName: "envelope.circle")
                                .foregroundColor(Color("colorBlack"))
                                .frame(width: 30, height: 30)
                                .background(Color("colorGray1"))
                                .cornerRadius(7.5)
                            Text("Write to the developer")
                                .foregroundColor(Color("colorBalanceText"))
                            Spacer()
                            Image(systemName: "chevron.forward")
                                .foregroundColor(Color("colorBalanceText"))
                                .opacity(0.5)
                        }
                    }
                    
                } header: {
                    Text("Feedback")
                }
            }
            .background(Color("colorBG"))
            .scrollContentBackground(.hidden)
            .navigationTitle("Settings")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Back")
                    }
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
