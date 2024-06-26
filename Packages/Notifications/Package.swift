// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Notifications",
    defaultLocalization: "en",
    platforms: [.iOS(.v18), .macOS(.v14)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "Notifications",
            targets: ["Notifications"]),
    ],
    dependencies: [
        .package(name: "Styleguide", path: "../Styleguide"),
        .package(name: "CommonDomain", path: "../CommonDomain"),
        .package(url: "https://github.com/apple/swift-log.git", exact: "1.6.1"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "Notifications",
            dependencies: [
                .product(name: "Styleguide", package: "Styleguide"),
                .product(name: "CommonDomain", package: "CommonDomain"),
                .product(name: "Logging", package: "swift-log")
            ]),
        .testTarget(
            name: "NotificationsTests",
            dependencies: ["Notifications"]
        ),
    ]
)
