//
//  Dependencies.swift
//  Modules
//
//  Created by Varun on 2026-05-26.
//

import FactoryKit

public extension Container {
    var logger: Factory<any Logging> {
        self {
            fatalError("Logging is not registered")
        }
    }
}
