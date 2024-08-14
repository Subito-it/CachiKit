// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CachiKit",
    platforms: [
        // specify each minimum deployment requirement,
        // otherwise the platform default minimum is used.
        .macOS(.v10_13),
    ],
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "CachiKit",
            targets: ["CachiKit"]
        ),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(url: "https://github.com/tcamin/ShellOut.git", .branch("master")),
        .package(url: "https://github.com/michaeleisel/ZippyJSON", .branch("master")),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "CachiKit",
            dependencies: ["ShellOut", "ZippyJSON"],
            path: "Sources"
        ),
        .testTarget(
            name: "CachiKitTests",
            dependencies: ["CachiKit"],
            path: "Tests"
        ),
    ]
)
