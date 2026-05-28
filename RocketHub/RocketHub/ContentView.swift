//
//  ContentView.swift
//  RocketHub
//
//  Created by Varun on 2026-05-24.
//

import Common
import FactoryKit
import GraphQLClient
import RocketAPI
import SwiftUI

struct ContentView: View {
    @Injected(\.graphQLClient) var graphQLClient: any GraphQLClient
    @Injected(\.logger) var logger: any Logging

    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .onAppear {
            logger.log("ContentView", level: .debug)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
