// swift-tools-version: 6.2
import PackageDescription

let package = Package(
    name: "Shared",
    platforms: [.iOS(.v17), .macOS(.v14)],
    products: [
        .library(name: "Shared", targets: ["Shared"]),
    ],
    dependencies: [
        .package(url: "https://github.com/no-problem-dev/swift-api-contract.git", .upToNextMajor(from: "1.0.0")),
    ],
    targets: [
        .target(
            name: "Shared",
            dependencies: [
                .product(name: "APIContract", package: "swift-api-contract"),
            ]
        ),
    ]
)
