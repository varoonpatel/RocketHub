//
//  LoginRepository.swift
//  Modules
//
//  Created by Varun on 2026-05-30.
//

public enum AuthicationError: Error {
    case loginFailed
}

public protocol LoginRepository: Sendable {
    func login(email: String) async throws
}
