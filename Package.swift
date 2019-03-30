// swift-tools-version:5.0
// Managed by ice

import PackageDescription

let package = Package(
    name: "GitVersion",
    products: [
        .executable(name: "gitversion", targets: ["GitVersion"]),
        .library(name: "GitVersionCLI", targets: ["GitVersionCLI"]),
        .library(name: "GitVersionKit", targets: ["GitVersionKit"]),
    ],
    dependencies: [
        .package(url: "https://github.com/JohnSundell/Files", from: "3.0.0"),
        .package(url: "https://github.com/nsomar/Guaka", from: "0.3.1"),
    ],
    targets: [
        .target(name: "GitVersion", dependencies: ["GitVersionCLI"]),
        .target(name: "GitVersionCLI", dependencies: ["GitVersionKit", "Guaka"]),
        .target(name: "GitVersionKit", dependencies: ["Files"]),
        .testTarget(name: "GitVersionKitTests", dependencies: ["GitVersionKit"]),
    ]
)
