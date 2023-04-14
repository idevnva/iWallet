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
    
    private let welcomeLocalized: LocalizedStringKey = "Welcome to the iWallet!"
    private let initialLocalized: LocalizedStringKey = "Initial application setup"
    private let pleaseLocalized: LocalizedStringKey = "please add transaction."
    
    @State private var vibrateOnSilent: Bool = true
    
    var body: some View {
        NavigationStack {
            Spacer()
            VStack(alignment: .center) {
                Spacer(minLength: 20)
                Image("icon")
                    .resizable()
                    .frame(width: 100, height: 100)
                Spacer(minLength: 50)
                Text("Welcome to the iWallet!")
                    .foregroundColor(.gray).bold()
                    .font(.title)
                Text(initialLocalized)
                    .foregroundColor(.gray)
                Spacer(minLength: 20)
                
                Text(initialLocalized)
                    .foregroundColor(.gray)
                    .font(.system(size: 12))
                Text(pleaseLocalized)
                    .foregroundColor(.gray)
                    .font(.system(size: 12))
                Spacer(minLength: 20)
            }
            .frame(maxWidth: .infinity, maxHeight: 300)
            HStack {
                Toggle("Switch", isOn: $vibrateOnSilent)
                    .toggleStyle(SwitchToggleStyle(tint: .accentColor))
            }
            Spacer()
            Button(action: {
                    hasRunBefore = true
                    if vibrateOnSilent {
                        viewModel.createDefaultCategories()
                    }
                })
            {
                Text("Continue")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
        }
                   
    }
}

struct CheckFirstRunView_Previews: PreviewProvider {
    static var previews: some View {
        CheckFirstRunView()
    }
}

