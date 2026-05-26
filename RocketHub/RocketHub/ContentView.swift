//
//  ContentView.swift
//  RocketHub
//
//  Created by Varun on 2026-05-24.
//

import FactoryKit
import GraphQLClient
import RocketAPI
import SwiftUI

struct ContentView: View {
    @Injected(\.graphQLClient) var graphQLClient: any GraphQLClient

    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
