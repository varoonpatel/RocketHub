//
//  GraphQLLoginRepository.swift
//  Modules
//
//  Created by Varun on 2026-05-30.
//

import Apollo
import FactoryKit
import GraphQLClient
import LoginDomain
import RocketAPI

public actor GraphQLLoginRepository: LoginRepository {
    private let graphqlClient: GraphQLClient = dependency(\.graphQLClient)

    public init() {}

    public func login(email: String) async throws {
        do {
            let response = try await graphqlClient.perform(
                mutation: LoginMutation(email: .some(email))
            )

            if response.data?.login?.token == nil {
                throw AuthicationError.loginFailed
            }
        } catch {
            throw AuthicationError.loginFailed
        }
    }
}
