//
//  Dependencies.swift
//  Modules
//
//  Created by Varun on 2026-05-26.
//

import FactoryKit
import Foundation

public extension Container {
    var logger: Factory<any Logging> {
        self {
            fatalError("Logging is not registered")
        }
    }

    var sharedStorage: Factory<UserDefaults> {
        self {
            fatalError("SharedStorage is not registered")
        }
    }
}
