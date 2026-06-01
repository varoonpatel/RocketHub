//
//  RocketHubApp.swift
//  RocketHub
//
//  Created by Varun on 2026-05-24.
//

import Common
import LoginFeature
import SwiftUI

@main
struct RocketHubApp: App {
    @AppStorage("isLoggedIn", store: SharedStgorage()) var isLoggedIn = false

    var body: some Scene {
        WindowGroup {
            if isLoggedIn {
                ContentView()
            } else {
                LoginView()
            }
        }
    }
}
