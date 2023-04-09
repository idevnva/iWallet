//  PreviewCard.swift

import SwiftUI

func previewCard() -> some View {
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
        
        Text("Список транзакций пока, что пуст,")
            .foregroundColor(.gray)
            .font(.system(size: 12))
        Text("пожалуйста добавьте транзакцию.")
            .foregroundColor(.gray)
            .font(.system(size: 12))
        Spacer(minLength: 20)
    }
    .frame(maxWidth: .infinity, maxHeight: 300)
}
