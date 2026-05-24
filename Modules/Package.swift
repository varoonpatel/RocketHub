// swift-tools-version: 6.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Modules",
    platforms: [.iOS(.v18), .macOS(.v15)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "Common",
            targets: ["Common"]
        ),
        .library(
            name: "GraphQLClient",
            targets: ["GraphQLClient"]
        ),
        .library(
            name: "GraphQLAPI",
            targets: ["GraphQLAPI"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/hmlongco/Factory", from: "3.0.4"),
        .package(url: "https://github.com/apollographql/apollo-ios", exact: "2.1.2")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "Common",
        ),
        .target(
            name: "GraphQLClient",
            dependencies: [
                .product(name: "FactoryKit", package: "Factory"),
                .product(name: "Apollo", package: "apollo-ios"),
            ]
        ),
        .target(
            name: "GraphQLAPI",
            dependencies: [
                .product(name: "Apollo", package: "apollo-ios"),
            ]
        )
    ],
    swiftLanguageModes: [.v6]
)
