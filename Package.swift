// swift-tools-version:4.2
// Managed by ice

import PackageDescription

let package = Package(
    name: "GitVersion",
    products: [
        .executable(name: "gitversion", targets: ["GitVersion"]),
    ],
    dependencies: [
        .package(url: "https://github.com/JohnSundell/Files", from: "2.2.1"),
    ],
    targets: [
        .target(name: "GitVersion", dependencies: ["GitVersionKit"]),
        .target(name: "GitVersionKit", dependencies: ["Files"]),
        .testTarget(name: "GitVersionKitTests", dependencies: ["GitVersionKit"]),
    ]
)
