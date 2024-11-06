// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AreYouSureButton",
    platforms: [
        .iOS(.v15),
    ],
    products: [
        .library(
            name: "AreYouSureButton",
            targets: ["AreYouSureButton"]),
    ],
 
    targets: [
        .target(
            name: "AreYouSureButton",
            swiftSettings: [.swiftLanguageMode(.v5)])
    ]
)
