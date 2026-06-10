//
//  RocketHubApp.swift
//  RocketHub
//
//  Created by Varun on 2026-05-24.
//

import Common
import HomeFeature
import LoginFeature
import SwiftUI

@main
struct RocketHubApp: App {
    @AppStorage("isLoggedIn", store: SharedStgorage()) var isLoggedIn = false

    var body: some Scene {
        WindowGroup {
            if isLoggedIn {
                TabView {
                    Tab("Home", systemImage: "house.fill") {
                        NavigationStack {
                            LaunchesListView()
                        }
                    }

                    Tab("My Trips", systemImage: "airplane") {
                        ContentView()
                    }
                }
                .tabViewStyle(.tabBarOnly)
            } else {
                LoginView()
            }
        }
    }
}
