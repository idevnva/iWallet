//  PreviewCard.swift

import SwiftUI

func previewCard() -> some View {
    VStack {
        let welcomeLocalized: LocalizedStringKey = "Welcome"
        let listLocalized: LocalizedStringKey = "The list of transactions is currently empty,"
        let pleaseLocalized: LocalizedStringKey = "please add transaction."
        
        VStack(alignment: .center) {
            Spacer(minLength: 20)
            Image("icon")
                .resizable()
                .frame(width: 25, height: 25)
            Spacer()
            Text("iWallet")
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
        }
        .frame(maxWidth: .infinity, maxHeight: 300)
    }
}
