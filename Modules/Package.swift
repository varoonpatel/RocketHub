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
            name: "CommonTestSupport",
            targets: ["CommonTestSupport"]
        ),
        .library(
            name: "GraphQLClient",
            targets: ["GraphQLClient"]
        ),
        .library(
            name: "GraphQLClientTestSupport",
            targets: ["GraphQLClientTestSupport"]
        ),
        .library(
            name: "RocketAPI",
            targets: ["RocketAPI"]
        ),
        .library(
            name: "LoginFeature",
            targets: ["LoginFeature"]
        ),
        .library(
            name: "LoginDomain",
            targets: ["LoginDomain"]
        ),
        .library(
            name: "LoginData",
            targets: ["LoginData"]
        ),
        .library(
            name: "HomeFeature",
            targets: ["HomeFeature"]
        ),
        .library(
            name: "HomeDomain",
            targets: ["HomeDomain"]
        ),
        .library(
            name: "HomeData",
            targets: ["HomeData"]
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
            dependencies: [
                .product(name: "FactoryKit", package: "Factory"),
            ]
        ),
        .target(
            name: "CommonTestSupport"
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
            name: "GraphQLClientTestSupport",
            dependencies: [
                "GraphQLClient",
                .product(name: "Apollo", package: "apollo-ios"),
            ]
        ),
        .target(
            name: "RocketAPI",
            dependencies: [
                .product(name: "Apollo", package: "apollo-ios"),
            ],
            path: "Sources/RocketAPI/Generated"
        ),
        .target(
            name: "LoginFeature",
            dependencies: [
                "Common",
                "LoginDomain",
                .product(name: "FactoryKit", package: "Factory"),
            ]
        ),
        .testTarget(
            name: "LoginFeatureTests",
            dependencies: [
                "LoginFeature",
                "CommonTestSupport",
                .product(name: "FactoryTesting", package: "Factory"),
            ]
        ),
        .target(
            name: "LoginDomain"
        ),
        .target(
            name: "LoginData",
            dependencies: [
                "LoginDomain",
                "GraphQLClient",
                .product(name: "FactoryKit", package: "Factory"),
            ]
        ),
        .testTarget(
            name: "LoginDataTests",
            dependencies: [
                "LoginData",
                "LoginDomain",
                "GraphQLClient",
                "GraphQLClientTestSupport",
                .product(name: "FactoryTesting", package: "Factory"),
            ]
        ),
        .target(
            name: "HomeFeature",
            dependencies: [
                "HomeDomain",
                .product(name: "FactoryKit", package: "Factory")
            ]
        ),
        .target(
            name: "HomeDomain",
            dependencies: [
                .product(name: "FactoryKit", package: "Factory")
            ]
        ),
        .target(
            name: "HomeData",
            dependencies: [
                "HomeDomain",
                "GraphQLClient",
                "RocketAPI",
                .product(name: "FactoryKit", package: "Factory"),
            ]
        ),
    ],
    swiftLanguageModes: [.v6]
)
