//
//  LaunchesResponse.swift
//  Modules
//
//  Created by Varun on 2026-06-06.
//

import Foundation

public struct LaunchesResponse: Sendable, Equatable {
    public let cursor: String
    public let hasMore: Bool
    public let launches: [Launch]

    public init(
        cursor: String,
        hasMore: Bool,
        launches: [Launch]
    ) {
        self.cursor = cursor
        self.hasMore = hasMore
        self.launches = launches
    }
}

public struct Launch: Identifiable, Sendable, Equatable, Hashable {
    public let id: String
    public let isBooked: Bool
    public let mission: Mission?
    public let rocket: Rocket?
    public let site: String?

    public init(
        id: String,
        isBooked: Bool,
        mission: Mission?,
        rocket: Rocket?,
        site: String?
    ) {
        self.id = id
        self.isBooked = isBooked
        self.mission = mission
        self.rocket = rocket
        self.site = site
    }
}

public struct Mission: Sendable, Equatable, Hashable {
    public let name: String?
    public let missionPatch: URL?

    public init(
        name: String?,
        missionPatch: URL?
    ) {
        self.name = name
        self.missionPatch = missionPatch
    }
}

public struct Rocket: Sendable, Equatable, Hashable {
    public let name: String?
    public let type: String?

    public init(
        name: String?,
        type: String?
    ) {
        self.name = name
        self.type = type
    }
}

public extension LaunchesResponse {
    static let preview = LaunchesResponse(
        cursor: "1583556631",
        hasMore: true,
        launches: [
            .crs21,
            .starlink15,
            .sentinel6,
            .crew1,
            .gpsIII,
        ]
    )
}

public extension Launch {
    static let crs21 = Launch(
        id: "110",
        isBooked: false,
        mission: .crs21,
        rocket: .falcon9,
        site: "KSC LC 39A"
    )

    static let starlink15 = Launch(
        id: "109",
        isBooked: false,
        mission: .starlink15,
        rocket: .falcon9,
        site: "CCAFS SLC 40"
    )

    static let sentinel6 = Launch(
        id: "108",
        isBooked: false,
        mission: .sentinel6,
        rocket: .falcon9,
        site: "VAFB SLC 4E"
    )

    static let crew1 = Launch(
        id: "107",
        isBooked: true,
        mission: .crew1,
        rocket: .falcon9,
        site: "KSC LC 39A"
    )

    static let gpsIII = Launch(
        id: "106",
        isBooked: false,
        mission: .gpsIII,
        rocket: .falcon9,
        site: "CCAFS SLC 40"
    )
}

public extension Mission {
    static let crs21 = Mission(
        name: "CRS-21",
        missionPatch: URL(string: "https://imgur.com/E7fjUBD.png")
    )

    static let starlink15 = Mission(
        name: "Starlink-15 (v1.0)",
        missionPatch: URL(string: "https://images2.imgbox.com/d2/3b/bQaWiil0_o.png")
    )

    static let sentinel6 = Mission(
        name: "Sentinel-6 Michael Freilich",
        missionPatch: nil
    )

    static let crew1 = Mission(
        name: "Crew-1",
        missionPatch: URL(string: "https://i.imgur.com/t5R4BAQ.png")
    )

    static let gpsIII = Mission(
        name: "GPS III SV04 (Sacagawea)",
        missionPatch: URL(string: "https://i.imgur.com/Ehe9AgY.png")
    )
}

public extension Rocket {
    static let falcon9 = Rocket(
        name: "Falcon 9",
        type: "FT"
    )
}
