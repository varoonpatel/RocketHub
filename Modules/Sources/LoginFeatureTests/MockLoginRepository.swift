//
//  MockLoginRepository.swift
//  Modules
//
//  Created by Varun on 2026-06-01.
//

import LoginDomain

// swiftlint:disable:next no_unchecked_sendable
public final class MockLoginRepository: @unchecked Sendable, LoginRepository {
    public enum Response: Sendable {
        case success
        case failure(any Error)
    }

    public private(set) var email: String?
    public var response: Response = .success

    public init() {}

    public func login(email: String) async throws {
        self.email = email

        switch response {
        case .success:
            return

        case let .failure(error):
            throw error
        }
    }
}
