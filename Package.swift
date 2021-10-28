// swift-tools-version:5.0

import PackageDescription

let package = Package(
    name: "AesEverywhere",
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "AesEverywhere",
            targets: ["AesEverywhere"]),
    ],
    dependencies: [
        .package(url: "https://github.com/Kitura/BlueCryptor.git", .exact("2.0.0"))
    ],
    targets: [
        .target(
            name: "AesEverywhere",
            dependencies: ["Cryptor"])
    ]
)
