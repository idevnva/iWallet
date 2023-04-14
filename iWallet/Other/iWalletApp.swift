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
    @AppStorage("hasRunBefore") private var hasRunBefore = false
    
    private let currentAppVersion = "1.1.0"
    
    init() {
        checkAndUpdateVersion()
    }
    
    private func checkAndUpdateVersion() {
        let storedAppVersion = UserDefaults.standard.string(forKey: "appVersion") ?? "1.0.1"
        
        if storedAppVersion == "1.0.1" && currentAppVersion == "1.1.0" {
            viewModel.clearDatabase()
            hasRunBefore = false
        }
        
        UserDefaults.standard.set(currentAppVersion, forKey: "appVersion")
    }
    
    var body: some Scene {
        let _ = print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.path)
        
        WindowGroup {
            if !hasRunBefore {
                withAnimation {
                    WelcomeView()
                        .environmentObject(viewModel)
                }
            } else {
                withAnimation {
                    HomeView()
                        .environmentObject(viewModel)
                }
            }
        }
    }
}



