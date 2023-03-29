//
//  SFIconPicker.swift
//  iWallet
//
//  Created by Владислав Новошинский on 28.03.2023.
//

import SwiftUI

struct IconPicker: View {
    @Binding var selectedImage: String
    private let images: [String] = ["folder.circle", "paperplane.circle", "tray.circle", "circle.circle", "circle.hexagongrid.circle", "book.circle", "newspaper.circle", "bookmark.circle", "graduationcap.circle", "backpack.circle", "paperclip.circle", "person.circle", "sportscourt.circle", "trophy.circle", "command.circle", "cloud.circle", "snowflake.circle", "drop.circle", "stop.circle", "circle.grid.3x3.circle", "star.circle", "heart.circle"]
    
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .center) {
                ForEach(images, id: \.self) { image in
                    HStack {
                        VStack {
                            Image(systemName: image)
                                .foregroundColor(Color("colorBalanceText"))
                                .font(.system(size: 40))
                        }
                    }
                    .opacity(image == selectedImage ? 1.0 : 0.5)
                    .scaleEffect(image == selectedImage ? 1.1 : 1.0)
                    .onTapGesture {
                        selectedImage = image
                    }
                }
            } .padding(.vertical, 5)
        } 
    }
}

struct IconPicker_Previews: PreviewProvider {
    static var previews: some View {
        IconPicker(selectedImage: .constant("folder.circle"))
    }
}
