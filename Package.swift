// swift-tools-version: 6.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "References",
    platforms: [
        .macOS(.v13),
    ],
    products: [
        .library(
            name: "References",
            targets: [
                "References"
            ]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/leviouwendijk/Primitives.git", branch: "master"),
    ],
    targets: [
        .target(
            name: "References",
            dependencies: [
                .product(name: "Primitives", package: "Primitives"),
            ]
        ),
    ],
    swiftLanguageModes: [.v6]
)
