// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "BuildTools",
    platforms: [.macOS(.v14)],
    dependencies: [
        .package(url: "https://github.com/nicklockwood/SwiftFormat", from: "0.61.1"),
    ],
    targets: [
        .target(name: "BuildTools", path: ""),
    ]
)
