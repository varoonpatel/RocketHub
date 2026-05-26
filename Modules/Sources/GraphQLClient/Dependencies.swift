//
//  Dependencies.swift
//  Modules
//
//  Created by Varun on 2026-05-25.
//

import FactoryKit

extension Container {
    public var graphQLClient: Factory<GraphQLClient> {
        self {
            fatalError("GraphQLCLient is not registered")
        }
    }
}
