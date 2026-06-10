// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

public extension RocketAPI.Objects {
  /// Simple wrapper around our list of launches that contains a cursor to the
  /// last item in the list. Pass this cursor to the launches query to fetch results
  /// after these.
  nonisolated static let LaunchConnection = ApolloAPI.Object(
    typename: "LaunchConnection",
    implementedInterfaces: [],
    keyFields: nil
  )
}