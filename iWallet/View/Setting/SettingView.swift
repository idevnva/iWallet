//  SettingView.swift

import SwiftUI

struct SettingView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.openURL) var openURL
    
    @State var showCategory: Bool = false
    @State var showTransactionView: Bool = false
    
    private let backLocalized: LocalizedStringKey = "Back"
    private let settingLocalized: LocalizedStringKey = "Settings"
    private let ransactionsLocalized: LocalizedStringKey = "Transactions"
    private let categoriesLocalized: LocalizedStringKey = "Categories"
    private let dataLocalized: LocalizedStringKey = "Data"
    private let webSiteLocalized: LocalizedStringKey = "Web-site"
    private let communityLocalized: LocalizedStringKey = "Community"
    private let writeToTheDeveloperLocalized: LocalizedStringKey = "Write to the developer"
    private let feedbackLocalized: LocalizedStringKey = "Feedback"
    
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
                            Text(ransactionsLocalized)
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
                            Text(categoriesLocalized)
                                .foregroundColor(Color("colorBalanceText"))
                            Spacer()
                            Image(systemName: "chevron.forward")
                                .foregroundColor(Color("colorBalanceText"))
                                .opacity(0.5)
                        }
                    }
                } header: {
                    Text(dataLocalized)
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
                            Text(webSiteLocalized)
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
                            Text(communityLocalized)
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
                            Text(writeToTheDeveloperLocalized)
                                .foregroundColor(Color("colorBalanceText"))
                            Spacer()
                            Image(systemName: "chevron.forward")
                                .foregroundColor(Color("colorBalanceText"))
                                .opacity(0.5)
                        }
                    }
                    
                } header: {
                    Text(feedbackLocalized)
                }
            }
            .background(Color("colorBG"))
            .scrollContentBackground(.hidden)
            .navigationTitle(settingLocalized)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Text(backLocalized)
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
