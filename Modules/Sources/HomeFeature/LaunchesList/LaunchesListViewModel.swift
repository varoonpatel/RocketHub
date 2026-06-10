//
//  LaunchesListViewModel.swift
//  Modules
//
//  Created by Varun on 2026-06-06.
//

import FactoryKit
import HomeDomain
import Observation

enum LaunchesListState: Equatable {
    case loading
    case loaded([Launch])
    case error(String)
}

@MainActor @Observable
final class LaunchesListViewModel {
    @ObservationIgnored
    @Injected(\.launchesRepository) private var launchesRepository

    var state: LaunchesListState = .loading
    var isLoadingNextPage = false

    var canLoadNextPage: Bool {
        shouldShowNextPageLoader && isLoadingNextPage == false
    }

    var shouldShowNextPageLoader: Bool {
        cursor.isEmpty == false && hasMoreData
    }

    private var cursor: String = ""
    private var hasMoreData = false

    init() {
        loadLaunches()
    }

    private func resetPaginationState() {
        cursor = ""
        hasMoreData = false
    }

    func reloadData() {
        guard state != .loading else {
            return
        }

        resetPaginationState()
        loadLaunches()
    }

    func loadNextPage() {
        guard canLoadNextPage else { return }
        loadLaunches()
    }

    private func loadLaunches(pageSize: Int32 = 10) {
        Task {
            let existingLaunches: [Launch]

            if case let .loaded(launches) = state, cursor.isEmpty == false {
                existingLaunches = launches
                isLoadingNextPage = true
            } else {
                existingLaunches = []
                state = .loading
            }

            do {
                let response = try await launchesRepository.launches(
                    pageSize: pageSize,
                    cursor: cursor
                )
                cursor = response.cursor
                hasMoreData = response.hasMore
                state = .loaded(existingLaunches + response.launches)
            } catch {
                if let error = error as? LaunchesError {
                    switch error {
                    case .dataNotAvailable:
                        state = .error("Data is currently unavailable. Please try after sometime.")
                    case .requestFailed:
                        state = .error("Request failed. Please try after sometime.")
                    }
                } else {
                    state = .error("Something went wrong, Please try later.")
                }
            }

            isLoadingNextPage = false
        }
    }
}
