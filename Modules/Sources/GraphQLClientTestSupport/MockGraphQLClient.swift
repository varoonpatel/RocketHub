//
//  MockGraphQLClient.swift
//  Modules
//
//  Created by Varun on 2026-05-31.
//

import Apollo
@_spi(Unsafe) import ApolloAPI
import Foundation
import GraphQLClient

// swiftlint:disable:next no_unchecked_sendable
public final class MockGraphQLClient: @unchecked Sendable, GraphQLClient {
    public enum Response {
        case rawJSON(String)
        case jsonFileURL(URL)
        case failure(any Swift.Error)
    }

    public private(set) var operationName: String?
    public var response: Response?

    public init() {}

    public func fetch<Query: GraphQLQuery>(
        query: Query,
        cachePolicy _: CachePolicy.Query.SingleResponse
    ) async throws -> GraphQLResponse<Query>
        where Query.ResponseFormat == SingleResponseFormat
    {
        operationName = Query.operationName
        return try await graphQLResponse(for: query)
    }

    public func perform<Mutation: GraphQLMutation>(
        mutation: Mutation
    ) async throws -> GraphQLResponse<Mutation>
        where Mutation.ResponseFormat == SingleResponseFormat
    {
        operationName = Mutation.operationName
        return try await graphQLResponse(for: mutation)
    }
}

private extension MockGraphQLClient {
    enum Error: Swift.Error {
        case missingResponse
        case invalidJSONFixture
        case invalidJSONObject
    }

    enum JSONFixtureValue: Hashable {
        case object([String: JSONFixtureValue])
        case array([JSONFixtureValue])
        case string(String)
        case bool(Bool)
        case int(Int)
        case double(Double)
        case null
    }

    func graphQLResponse<Operation: GraphQLOperation>(
        for operation: Operation
    ) async throws -> GraphQLResponse<Operation>
        where Operation.ResponseFormat == SingleResponseFormat
    {
        guard let response else {
            throw Error.missingResponse
        }

        switch response {
        case let .rawJSON(rawJSON):
            return try await Self.graphQLResponse(
                from: Data(rawJSON.utf8),
                operation: operation
            )

        case let .jsonFileURL(url):
            return try await Self.graphQLResponse(
                from: Data(contentsOf: url),
                operation: operation
            )

        case let .failure(error):
            throw error
        }
    }

    static func graphQLResponse<Operation: GraphQLOperation>(
        from jsonData: Data,
        operation: Operation
    ) async throws -> GraphQLResponse<Operation>
        where Operation.ResponseFormat == SingleResponseFormat
    {
        guard let json = try JSONSerialization.jsonObject(with: jsonData) as? [String: Any] else {
            throw Error.invalidJSONFixture
        }

        let hasGraphQLEnvelope = json.keys.contains("data")
            || json.keys.contains("errors")
            || json.keys.contains("extensions")

        let dataObject: [String: Any]? = if hasGraphQLEnvelope {
            json["data"] as? [String: Any]
        } else {
            json
        }

        let data: Operation.Data? = if let dataObject {
            try await Operation.Data(data: dataObject, variables: operation.__variables)
        } else {
            nil
        }

        return try GraphQLResponse(
            data: data,
            extensions: jsonObject(from: json["extensions"]),
            errors: graphQLErrors(from: json["errors"]),
            source: .server,
            dependentKeys: nil
        )
    }

    static func graphQLErrors(from value: Any?) throws -> [GraphQLError]? {
        guard let errors = value as? [[String: Any]] else {
            return nil
        }

        return try errors.map {
            try GraphQLError(jsonObject(from: $0) ?? [:])
        }
    }

    static func jsonObject(from value: Any?) throws -> JSONObject? {
        guard let dictionary = value as? [String: Any] else {
            return nil
        }

        var object = JSONObject()
        for (key, value) in dictionary {
            object[key] = try jsonValue(from: value)
        }
        return object
    }

    static func jsonValue(from value: Any) throws -> JSONValue {
        switch value {
        case let value as [String: Any]:
            return try JSONFixtureValue.object(
                value.mapValues { try jsonFixtureValue(from: $0) }
            )
        case let value as [Any]:
            return try JSONFixtureValue.array(
                value.map { try jsonFixtureValue(from: $0) }
            )
        case let value as String:
            return value
        case let value as Bool:
            return value
        case let value as Int:
            return value
        case let value as Double:
            return value
        case is NSNull:
            return NSNull()
        default:
            throw Error.invalidJSONObject
        }
    }

    static func jsonFixtureValue(from value: Any) throws -> JSONFixtureValue {
        switch value {
        case let value as [String: Any]:
            return try .object(value.mapValues { try jsonFixtureValue(from: $0) })
        case let value as [Any]:
            return try .array(value.map { try jsonFixtureValue(from: $0) })
        case let value as String:
            return .string(value)
        case let value as Bool:
            return .bool(value)
        case let value as Int:
            return .int(value)
        case let value as Double:
            return .double(value)
        case is NSNull:
            return .null
        default:
            throw Error.invalidJSONObject
        }
    }
}
