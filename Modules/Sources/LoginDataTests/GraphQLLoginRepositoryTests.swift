//
//  GraphQLLoginRepositoryTests.swift
//  Modules
//
//  Created by Varun on 2026-05-31.
//

import FactoryKit
import FactoryTesting
import GraphQLClientTestSupport
import LoginData
import LoginDomain
import Testing

@Suite(.container)
struct GraphQLLoginRepositoryTests {
    var mockGraphQLClient: MockGraphQLClient?
    let loginRepository: GraphQLLoginRepository

    init() {
        let mockClient = MockGraphQLClient()
        mockGraphQLClient = mockClient
        Container.shared.graphQLClient.register {
            mockClient
        }
        loginRepository = GraphQLLoginRepository()
    }

    @Test("when login mutation is called and response returned with null token should fail")
    func loginMutationWithoutToken() async throws {
        mockGraphQLClient?.response = .rawJSON("""
        {
          "data": {
            "login": {
              "__typename": "User",
              "id": "11",
              "email": "test@test.com",
              "token": nil
            }
          }
        }
        """)

        await #expect(throws: AuthicationError.loginFailed.self) {
            try await loginRepository.login(email: "test@test.com")
        }
    }

    @Test("when login mutation is called and response returned with valid token should pass")
    func loginMutationWithValidResponse() async throws {
        mockGraphQLClient?.response = .rawJSON("""
        {
          "data": {
            "login": {
              "__typename": "User",
              "id": "11",
              "email": "test@test.com",
              "token": "abc123"
            }
          }
        }
        """)

        try await loginRepository.login(email: "test@test.com")
        #expect(mockGraphQLClient?.operationName == "Login")
    }
}
