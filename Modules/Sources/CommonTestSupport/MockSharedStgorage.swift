//
//  MockSharedStgorage.swift
//  Modules
//
//  Created by Varun on 2026-06-01.
//

import Foundation

public final class MockSharedStgorage: UserDefaults {
    public private(set) var key: String?
    public private(set) var value: Any?

    override public init?(suiteName suitename: String?) {
        super.init(suiteName: suitename)
    }

    override public func set(_ value: Any?, forKey defaultName: String) {
        key = defaultName
        self.value = value
    }
}
