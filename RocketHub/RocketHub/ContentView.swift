//
//  ContentView.swift
//  RocketHub
//
//  Created by Varun on 2026-05-24.
//

import RocketAPI
import FactoryKit
import SwiftUI
import GraphQLClient

struct ContentView: View {
    @Injected(\.graphQLClient) var graphQLClient: any GraphQLClient
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .task {
            do {
                let user = try await graphQLClient.perform(mutation: LoginMutation(email: "test@test.com"))
                print("User: \(user)")
            } catch {
                print("Error \(error.localizedDescription)")
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
