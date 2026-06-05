// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

nonisolated public protocol RocketAPI_SelectionSet: ApolloAPI.SelectionSet & ApolloAPI.RootSelectionSet
where Schema == RocketAPI.SchemaMetadata {}

nonisolated public protocol RocketAPI_InlineFragment: ApolloAPI.SelectionSet & ApolloAPI.InlineFragment
where Schema == RocketAPI.SchemaMetadata {}

nonisolated public protocol RocketAPI_MutableSelectionSet: ApolloAPI.MutableRootSelectionSet
where Schema == RocketAPI.SchemaMetadata {}

nonisolated public protocol RocketAPI_MutableInlineFragment: ApolloAPI.MutableSelectionSet & ApolloAPI.InlineFragment
where Schema == RocketAPI.SchemaMetadata {}

public extension RocketAPI {
  typealias SelectionSet = RocketAPI_SelectionSet

  typealias InlineFragment = RocketAPI_InlineFragment

  typealias MutableSelectionSet = RocketAPI_MutableSelectionSet

  typealias MutableInlineFragment = RocketAPI_MutableInlineFragment

  nonisolated enum SchemaMetadata: ApolloAPI.SchemaMetadata {
    public static let configuration: any ApolloAPI.SchemaConfiguration.Type = SchemaConfiguration.self

    private static let objectTypeMap: [String: ApolloAPI.Object] = [
      "Mutation": RocketAPI.Objects.Mutation,
      "User": RocketAPI.Objects.User
    ]

    @_spi(Execution) public static func objectType(forTypename typename: String) -> ApolloAPI.Object? {
      objectTypeMap[typename]
    }
  }

  nonisolated enum Objects {}
  nonisolated enum Interfaces {}
  nonisolated enum Unions {}

}