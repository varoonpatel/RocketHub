//
//  Dependencies.swift
//  Modules
//
//  Created by Varun on 2026-05-30.
//

import FactoryKit
import LoginDomain

public extension Container {
    var loginRepository: Factory<LoginRepository> {
        self {
            fatalError("GraphQLLoginRepository is not registered")
        }
    }
}
