// swift-tools-version: 6.2
import PackageDescription

let package = Package(
    name: "Presentation",
    platforms: [.iOS(.v17), .macOS(.v14)],
    products: [
        .library(name: "Presentation", targets: ["Presentation"]),
    ],
    dependencies: [
        .package(path: "../../../Shared"),
        .package(path: "../UseCases"),
        .package(url: "https://github.com/no-problem-dev/swift-statable.git", .upToNextMajor(from: "1.0.0")),
        .package(url: "https://github.com/no-problem-dev/swift-design-system.git", .upToNextMajor(from: "1.0.0")),
        .package(url: "https://github.com/no-problem-dev/swift-authentication.git", .upToNextMajor(from: "1.0.0")),
        .package(url: "https://github.com/no-problem-dev/swift-ui-routing.git", .upToNextMajor(from: "1.0.0")),
    ],
    targets: [
        .target(
            name: "Presentation",
            dependencies: [
                "Shared",
                "UseCases",
                .product(name: "Statable", package: "swift-statable"),
                .product(name: "DesignSystem", package: "swift-design-system"),
                .product(name: "Authentication", package: "swift-authentication"),
                .product(name: "UIRouting", package: "swift-ui-routing"),
            ],
            resources: [.process("Resources")]
        ),
    ]
)
