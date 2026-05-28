//
//  GraphQLClient.swift
//  Modules
//
//  Created by Varun on 2026-05-25.
//

import Apollo
import Foundation
import RocketAPI

public protocol GraphQLClient: Sendable {
    func fetch<Query: GraphQLQuery>(
        query: Query,
        cachePolicy: CachePolicy.Query.SingleResponse
    ) async throws -> GraphQLResponse<Query>
        where Query.ResponseFormat == SingleResponseFormat

    func perform<Mutation: GraphQLMutation>(
        mutation: Mutation
    ) async throws -> GraphQLResponse<Mutation>
        where Mutation.ResponseFormat == SingleResponseFormat
}
