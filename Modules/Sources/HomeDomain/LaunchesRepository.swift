//
//  LaunchesRepository.swift
//  Modules
//
//  Created by Varun on 2026-06-05.
//

public enum LaunchesError: Error {
    case dataNotAvailable
    case requestFailed
}

public protocol LaunchesRepository: Sendable {
    func launches(pageSize: Int32, cursor: String) async throws -> LaunchesResponse
}
