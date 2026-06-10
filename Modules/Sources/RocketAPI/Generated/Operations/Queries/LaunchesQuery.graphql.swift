// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI
@_spi(Execution) @_spi(Unsafe) import ApolloAPI

public extension RocketAPI {
  nonisolated struct LaunchesQuery: GraphQLQuery {
    public static let operationName: String = "Launches"
    public static let operationDocument: ApolloAPI.OperationDocument = .init(
      definition: .init(
        #"query Launches($pageSize: Int, $cursor: String) { launches(pageSize: $pageSize, after: $cursor) { __typename cursor hasMore launches { __typename id isBooked mission { __typename name missionPatch } rocket { __typename name type } site } } }"#
      ))

    public var pageSize: GraphQLNullable<Int32>
    public var cursor: GraphQLNullable<String>

    public init(
      pageSize: GraphQLNullable<Int32>,
      cursor: GraphQLNullable<String>
    ) {
      self.pageSize = pageSize
      self.cursor = cursor
    }

    @_spi(Unsafe) public var __variables: Variables? { [
      "pageSize": pageSize,
      "cursor": cursor
    ] }

    nonisolated public struct Data: RocketAPI.SelectionSet {
      @_spi(Unsafe) public let __data: DataDict
      @_spi(Unsafe) public init(_dataDict: DataDict) { __data = _dataDict }

      @_spi(Execution) public static var __parentType: any ApolloAPI.ParentType { RocketAPI.Objects.Query }
      @_spi(Execution) public static var __selections: [ApolloAPI.Selection] { [
        .field("launches", Launches.self, arguments: [
          "pageSize": .variable("pageSize"),
          "after": .variable("cursor")
        ]),
      ] }
      @_spi(Execution) public static var __fulfilledFragments: [any ApolloAPI.SelectionSet.Type] { [
        LaunchesQuery.Data.self
      ] }

      public var launches: Launches { __data["launches"] }

      /// Launches
      ///
      /// Parent Type: `LaunchConnection`
      nonisolated public struct Launches: RocketAPI.SelectionSet {
        @_spi(Unsafe) public let __data: DataDict
        @_spi(Unsafe) public init(_dataDict: DataDict) { __data = _dataDict }

        @_spi(Execution) public static var __parentType: any ApolloAPI.ParentType { RocketAPI.Objects.LaunchConnection }
        @_spi(Execution) public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("cursor", String.self),
          .field("hasMore", Bool.self),
          .field("launches", [Launch?].self),
        ] }
        @_spi(Execution) public static var __fulfilledFragments: [any ApolloAPI.SelectionSet.Type] { [
          LaunchesQuery.Data.Launches.self
        ] }

        public var cursor: String { __data["cursor"] }
        public var hasMore: Bool { __data["hasMore"] }
        public var launches: [Launch?] { __data["launches"] }

        /// Launches.Launch
        ///
        /// Parent Type: `Launch`
        nonisolated public struct Launch: RocketAPI.SelectionSet {
          @_spi(Unsafe) public let __data: DataDict
          @_spi(Unsafe) public init(_dataDict: DataDict) { __data = _dataDict }

          @_spi(Execution) public static var __parentType: any ApolloAPI.ParentType { RocketAPI.Objects.Launch }
          @_spi(Execution) public static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .field("id", RocketAPI.ID.self),
            .field("isBooked", Bool.self),
            .field("mission", Mission?.self),
            .field("rocket", Rocket?.self),
            .field("site", String?.self),
          ] }
          @_spi(Execution) public static var __fulfilledFragments: [any ApolloAPI.SelectionSet.Type] { [
            LaunchesQuery.Data.Launches.Launch.self
          ] }

          public var id: RocketAPI.ID { __data["id"] }
          public var isBooked: Bool { __data["isBooked"] }
          public var mission: Mission? { __data["mission"] }
          public var rocket: Rocket? { __data["rocket"] }
          public var site: String? { __data["site"] }

          /// Launches.Launch.Mission
          ///
          /// Parent Type: `Mission`
          nonisolated public struct Mission: RocketAPI.SelectionSet {
            @_spi(Unsafe) public let __data: DataDict
            @_spi(Unsafe) public init(_dataDict: DataDict) { __data = _dataDict }

            @_spi(Execution) public static var __parentType: any ApolloAPI.ParentType { RocketAPI.Objects.Mission }
            @_spi(Execution) public static var __selections: [ApolloAPI.Selection] { [
              .field("__typename", String.self),
              .field("name", String?.self),
              .field("missionPatch", String?.self),
            ] }
            @_spi(Execution) public static var __fulfilledFragments: [any ApolloAPI.SelectionSet.Type] { [
              LaunchesQuery.Data.Launches.Launch.Mission.self
            ] }

            public var name: String? { __data["name"] }
            public var missionPatch: String? { __data["missionPatch"] }
          }

          /// Launches.Launch.Rocket
          ///
          /// Parent Type: `Rocket`
          nonisolated public struct Rocket: RocketAPI.SelectionSet {
            @_spi(Unsafe) public let __data: DataDict
            @_spi(Unsafe) public init(_dataDict: DataDict) { __data = _dataDict }

            @_spi(Execution) public static var __parentType: any ApolloAPI.ParentType { RocketAPI.Objects.Rocket }
            @_spi(Execution) public static var __selections: [ApolloAPI.Selection] { [
              .field("__typename", String.self),
              .field("name", String?.self),
              .field("type", String?.self),
            ] }
            @_spi(Execution) public static var __fulfilledFragments: [any ApolloAPI.SelectionSet.Type] { [
              LaunchesQuery.Data.Launches.Launch.Rocket.self
            ] }

            public var name: String? { __data["name"] }
            public var type: String? { __data["type"] }
          }
        }
      }
    }
  }

}