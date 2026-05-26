//
//  DefaultGraphQLClient.swift
//  Modules
//
//  Created by Varun on 2026-05-25.
//

import Apollo
import Foundation
import RocketAPI

public final class DefaultGraphQLClient: GraphQLClient {
    let apolloClient: ApolloClient
    
    public init(apolloClient: ApolloClient) {
        self.apolloClient = apolloClient
    }
    
    convenience public init(url: URL?) {
        guard let url else {
            fatalError("GraphQL Server URL is nil")
        }
        
        let apolloClient = ApolloClient(url: url)
        self.init(apolloClient: apolloClient)
    }
    
    public func fetch<Query>(
        query: Query,
        cachePolicy: Apollo.CachePolicy.Query.SingleResponse = .networkFirst
    ) async throws -> Apollo.GraphQLResponse<Query> where Query : ApolloAPI.GraphQLQuery, Query.ResponseFormat == ApolloAPI.SingleResponseFormat {
        try await apolloClient.fetch(query: query, cachePolicy: cachePolicy)
    }
    
    public func perform<Mutation>(
        mutation: Mutation
    ) async throws -> Apollo.GraphQLResponse<Mutation> where Mutation : ApolloAPI.GraphQLMutation, Mutation.ResponseFormat == ApolloAPI.SingleResponseFormat {
        try await apolloClient.perform(mutation: mutation)
    }
}
