//
//  LaunchesListView.swift
//  Modules
//
//  Created by Varun on 2026-06-05.
//

import HomeDomain
import SwiftUI

public struct LaunchesListView: View {
    @State private var viewModel: LaunchesListViewModel = .init()

    public init() {}

    public var body: some View {
        VStack {
            switch viewModel.state {
            case .loading:
                ProgressView()
            case let .loaded(launches):
                launchesList(launches)
            case let .error(string):
                ContentUnavailableView(label: {
                    Text(string)
                }, actions: {
                    Button("Reload") {
                        Task {
                            viewModel.reloadData()
                        }
                    }
                    .buttonStyle(.borderedProminent)
                    .padding()
                })
            }
        }
        .navigationDestination(for: HomeRoute.self, destination: { destination in
            switch destination {
            case let .launchesDetail(launch):
                LaunchDetails(launch: launch)
            }
        })
        .refreshable {
            viewModel.reloadData()
        }
        .navigationTitle("Launches")
    }

    private func launchesList(_ launches: [Launch]) -> some View {
        List {
            ForEach(launches) { item in
                NavigationLink(value: HomeRoute.launchesDetail(item)) {
                    LaunchesListRowView(launch: item)
                }
                .task {
                    if launches.last == item {
                        viewModel.loadNextPage()
                    }
                }
            }

            if viewModel.shouldShowNextPageLoader {
                HStack {
                    Spacer()
                    ProgressView()
                    Spacer()
                }
            }
        }
        .listStyle(.plain)
    }
}

#Preview {
    NavigationStack {
        LaunchesListView()
    }
}
