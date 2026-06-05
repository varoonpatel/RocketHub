//
//  DefaultGraphQLClient.swift
//  Modules
//
//  Created by Varun on 2026-05-25.
//

import Apollo
import Foundation
import RocketAPI

public actor DefaultGraphQLClient: GraphQLClient {
    let apolloClient: ApolloClient

    public init(apolloClient: ApolloClient) {
        self.apolloClient = apolloClient
    }

    public init(url: URL?) {
        guard let url else {
            fatalError("GraphQL Server URL is nil")
        }

        let apolloClient = ApolloClient(url: url)
        self.init(apolloClient: apolloClient)
    }

    public func fetch<Query: ApolloAPI.GraphQLQuery>(
        query: Query,
        cachePolicy: Apollo.CachePolicy.Query.SingleResponse = .networkFirst
    ) async throws -> Apollo.GraphQLResponse<Query> where Query.ResponseFormat == ApolloAPI.SingleResponseFormat {
        try await apolloClient.fetch(query: query, cachePolicy: cachePolicy)
    }

    public func perform<Mutation: ApolloAPI.GraphQLMutation>(
        mutation: Mutation
    ) async throws -> Apollo.GraphQLResponse<Mutation> where Mutation.ResponseFormat == ApolloAPI.SingleResponseFormat {
        try await apolloClient.perform(mutation: mutation)
    }
}
