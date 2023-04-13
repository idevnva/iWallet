//
//  CheckFirstRun.swift
//  iWallet
//
//  Created by Владислав Новошинский on 14.04.2023.
//

import SwiftUI
import RealmSwift

struct CheckFirstRunView: View {
    @EnvironmentObject var viewModel: SceneViewModel
    @AppStorage("hasRunBefore") private var hasRunBefore = false
    
    let welcomeLocalized: LocalizedStringKey = "Welcome to the iWallet!"
    let listLocalized: LocalizedStringKey = "The list of transactions is currently empty,"
    let pleaseLocalized: LocalizedStringKey = "please add transaction."
    
    @State private var vibrateOnSilent: Bool = true
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .center) {
                Spacer(minLength: 20)
                Image("icon")
                    .resizable()
                    .frame(width: 25, height: 25)
                Spacer()
                Text("Welcome to the iWallet!")
                    .foregroundColor(.gray).bold()
                    .font(.title)
                Text(welcomeLocalized)
                    .foregroundColor(.gray)
                Spacer(minLength: 20)
                
                Text(listLocalized)
                    .foregroundColor(.gray)
                    .font(.system(size: 12))
                Text(pleaseLocalized)
                    .foregroundColor(.gray)
                    .font(.system(size: 12))
                Spacer(minLength: 20)
                
                Button(action: {
                    hasRunBefore = true
                    if vibrateOnSilent {
                            viewModel.createDefaultCategories()
                        }
                }) {
                    Text("Continue")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                
            }
            .frame(maxWidth: .infinity, maxHeight: 300)
            HStack {
                Toggle("Switch", isOn: $vibrateOnSilent)
                    .toggleStyle(SwitchToggleStyle(tint: .accentColor))
            }
        }
    }
}

struct CheckFirstRunView_Previews: PreviewProvider {
    static var previews: some View {
        CheckFirstRunView()
    }
}

