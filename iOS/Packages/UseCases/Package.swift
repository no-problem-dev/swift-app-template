// swift-tools-version: 6.2
import PackageDescription

let package = Package(
    name: "UseCases",
    platforms: [.iOS(.v17), .macOS(.v14)],
    products: [
        .library(name: "UseCases", targets: ["UseCases"]),
    ],
    dependencies: [
        .package(path: "../../../Shared"),
        .package(url: "https://github.com/no-problem-dev/swift-api-client.git", .upToNextMajor(from: "1.0.0")),
        .package(url: "https://github.com/no-problem-dev/swift-authentication.git", .upToNextMajor(from: "1.0.0")),
    ],
    targets: [
        .target(
            name: "UseCases",
            dependencies: [
                "Shared",
                .product(name: "APIClient", package: "swift-api-client"),
                .product(name: "Authentication", package: "swift-authentication"),
            ]
        ),
    ]
)
