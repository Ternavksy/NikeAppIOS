//
//  NikeAppIOSApp.swift
//  NikeAppIOS
//
//

import SwiftUI

@main
struct NikeAppIOSApp: App {
    var body: some Scene {
        WindowGroup {
            SplashScreen()
                .onAppear {
                    ConfigCheck.check()
                }
        }
    }
}

