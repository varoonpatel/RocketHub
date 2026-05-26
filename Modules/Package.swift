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
            name: "RocketAPI",
            targets: ["RocketAPI"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/hmlongco/Factory", from: "3.0.4"),
        .package(url: "https://github.com/apollographql/apollo-ios", exact: "2.1.2"),
        .package(url: "https://github.com/SimplyDanny/SwiftLintPlugins", exact: "0.63.2"),
        .package(url: "https://github.com/nicklockwood/SwiftFormat", from: "0.61.1")
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
                "RocketAPI",
                .product(name: "FactoryKit", package: "Factory"),
                .product(name: "Apollo", package: "apollo-ios"),
            ]
        ),
        .target(
            name: "RocketAPI",
            dependencies: [
                .product(name: "Apollo", package: "apollo-ios"),
            ],
            path: "Sources/RocketAPI/Generated"
        )
    ],
    swiftLanguageModes: [.v6]
)
