// swift-tools-version:4.0

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
        .package(url: "https://github.com/IBM-Swift/BlueCryptor.git", .exact("1.0.31"))
    ],
    targets: [
        .target(
            name: "AesEverywhere",
            dependencies: ["Cryptor"])
    ]
)
