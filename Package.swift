// swift-tools-version: 6.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "References",
    products: [
        .library(
            name: "References",
            targets: [
                "References"
            ]
        ),
    ],
    targets: [
        .target(
            name: "References"
        ),
    ],
    swiftLanguageModes: [.v6]
)
