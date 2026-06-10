//
//  GraphQLLaunchesRepository.swift
//  Modules
//
//  Created by Varun on 2026-06-09.
//

import FactoryKit
import Foundation
import GraphQLClient
import HomeDomain
import RocketAPI

public actor GraphQLLaunchesRepository: LaunchesRepository {
    private let graphqlClient: GraphQLClient = dependency(\.graphQLClient)

    public init() {}

    public func launches(pageSize: Int32, cursor: String) async throws -> LaunchesResponse {
        do {
            let response = try await graphqlClient.fetch(query: RocketAPI.LaunchesQuery(pageSize: .some(pageSize), cursor: .some(cursor)), cachePolicy: .networkFirst)
            if let responseModel = response.data?.launches.toDomain() {
                return responseModel
            } else {
                throw LaunchesError.dataNotAvailable
            }
        } catch {
            throw LaunchesError.requestFailed
        }
    }
}

extension RocketAPI.LaunchesQuery.Data.Launches {
    func toDomain() -> LaunchesResponse {
        .init(
            cursor: cursor,
            hasMore: hasMore,
            launches: launches.compactMap { $0?.toDomain() }
        )
    }
}

extension RocketAPI.LaunchesQuery.Data.Launches.Launch {
    func toDomain() -> Launch {
        .init(
            id: id,
            isBooked: isBooked,
            mission: mission?.toDomain(),
            rocket: rocket?.toDomain(),
            site: site
        )
    }
}

extension RocketAPI.LaunchesQuery.Data.Launches.Launch.Mission {
    func toDomain() -> Mission {
        .init(
            name: name,
            missionPatch: URL(string: missionPatch ?? "")
        )
    }
}

extension RocketAPI.LaunchesQuery.Data.Launches.Launch.Rocket {
    func toDomain() -> Rocket {
        .init(
            name: name,
            type: type
        )
    }
}
