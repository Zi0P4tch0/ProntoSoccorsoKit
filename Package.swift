// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ProntoSoccorsoKit",
    platforms: [
        .iOS(.v12)
    ],
    products: [
        .library(
            name: "ProntoSoccorsoKit",
            targets: ["ProntoSoccorsoKit"])
    ],
    dependencies: [
        .package(url: "https://github.com/scinfu/SwiftSoup.git", from: "2.0.0")
    ],
    targets: [
        .target(
            name: "ProntoSoccorsoKit",
            dependencies: ["SwiftSoup"],
            path: "ProntoSoccorsoKit")
    ],
    swiftLanguageVersions: [.version("5")]
)
