//
//  Dependencies.swift
//  Modules
//
//  Created by Varun on 2026-06-09.
//

import FactoryKit

public extension Container {
    var launchesRepository: Factory<LaunchesRepository> {
        self {
            fatalError("GraphQLLaunchesRepository is not registered")
        }
    }
}
