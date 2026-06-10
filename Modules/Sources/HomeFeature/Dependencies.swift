//
//  Dependencies.swift
//  Modules
//
//  Created by Varun on 2026-06-09.
//

import FactoryKit
import HomeDomain

public extension Container {
    var launchesRepository: Factory<LaunchesRepository> {
        self {
            fatalError("GraphQLLoginRepository is not registered")
        }
    }
}
