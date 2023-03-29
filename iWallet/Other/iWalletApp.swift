//
//  iWalletApp.swift
//  iWallet
//
//  Created by Владислав Новошинский on 28.03.2023.
//

import SwiftUI

@main
struct iWalletApp: App {
    @ObservedObject var viewModel = SceneViewModel()
    
    var body: some Scene {
        let _ = print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.path)
        
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }
}
