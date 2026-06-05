//
//  SharedStorage.swift
//  Modules
//
//  Created by Varun on 2026-05-24.
//

import Foundation

public final class SharedStgorage: UserDefaults {
    override public init?(suiteName suitename: String?) {
        super.init(suiteName: suitename)
    }
}
