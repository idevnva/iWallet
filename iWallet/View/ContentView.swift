//
//  ContentView.swift
//  iWallet
//
//  Created by Владислав Новошинский on 28.03.2023.
//

import SwiftUI
import RealmSwift

struct ContentView: View {
    @EnvironmentObject var viewModel: SceneViewModel
    @ObservedResults(Category.self) var categories
    @State private var showSettingView: Bool = false
    @State private var showAddTransaction: Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: Alignment(horizontal: .trailing, vertical: .bottom)) {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack {
                        HStack {
                            BalanceView(amount: 100000, type: "Баланс", icon: "equal.circle", viewBG: Color("colorBalanceBG"), amountBG: Color("colorBalanceText"), typeBG: .gray, iconBG: Color("colorBlue"))
                            Spacer(minLength: 10)
                            BalanceView(amount: 1000, type: "Средняя за день", icon: "plusminus.circle", viewBG: Color("colorBalanceBG"), amountBG: Color("colorBalanceText"), typeBG: .gray, iconBG: Color("colorYellow"))
                        }
                        Spacer(minLength: 10)
                        HStack {
                            BalanceView(amount: 1000, type: "Доход", icon: "plus.circle", viewBG: Color("colorBalanceBG"), amountBG: Color("colorBalanceText"), typeBG: .gray, iconBG: Color("colorGreen"))
                            Spacer(minLength: 10)
                            BalanceView(amount: 1000, type: "Расход", icon: "minus.circle", viewBG: Color("colorBalanceBG"), amountBG: Color("colorBalanceText"), typeBG: .gray, iconBG: Color("colorRed"))
                        }
                    }
                    .padding()
                }
                
                HStack {
                    Button {
                        showAddTransaction.toggle()
                    } label: {
                        ZStack {
                            Circle()
                                .frame(width: 50, height: 50)
                                .foregroundColor(Color("colorBalanceText"))
                            Image(systemName: "plus")
                                .foregroundColor(Color("colorBG"))
                                .font(.system(size: 25))
                        }
                    }
                }
                .padding()
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            showSettingView.toggle()
                        } label: {
                            Image(systemName: "gearshape.circle")
                                .font(.title3)
                                .foregroundColor(Color("colorBalanceText"))
                        }
                    }
                    ToolbarItem(placement: .navigationBarLeading) {
                        Text("iWallet")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(Color("colorBalanceText"))
                    }
                }
            }
            .background(Color("colorBG"))
        } .fullScreenCover(isPresented: $showSettingView) {
            SettingView()
        }
        .sheet(isPresented: $showAddTransaction) {
            AddTransaction(selectedCategory: Category())
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = SceneViewModel()
        let cofiguration = Realm.Configuration(inMemoryIdentifier: "Preview")
        
        ContentView()
            .environmentObject(viewModel)
            .environment(\.realmConfiguration, cofiguration)
    }
}
