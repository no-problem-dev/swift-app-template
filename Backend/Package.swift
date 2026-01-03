// swift-tools-version: 6.2

import PackageDescription

let package = Package(
    name: "Backend",
    platforms: [
        .macOS(.v15),
    ],
    products: [
        .library(name: "BackendServices", targets: ["BackendServices"]),
        .executable(name: "Server", targets: ["Server"]),
    ],
    dependencies: [
        .package(path: "../Shared"),
        .package(url: "https://github.com/no-problem-dev/swift-api-server.git", .upToNextMajor(from: "1.0.0")),
        .package(url: "https://github.com/no-problem-dev/swift-firebase-server.git", .upToNextMajor(from: "1.0.0")),
        .package(url: "https://github.com/no-problem-dev/swift-env.git", .upToNextMajor(from: "1.0.0")),
    ],
    targets: [
        .target(
            name: "BackendServices",
            dependencies: [
                "Shared",
                .product(name: "FirestoreServer", package: "swift-firebase-server"),
                .product(name: "FirestoreSchema", package: "swift-firebase-server"),
                .product(name: "Env", package: "swift-env"),
            ],
            path: "Sources/Services"
        ),
        .executableTarget(
            name: "Server",
            dependencies: [
                "BackendServices",
                .product(name: "APIServer", package: "swift-api-server"),
                .product(name: "FirebaseAuthServer", package: "swift-firebase-server"),
            ],
            path: "Sources/Server"
        ),
        .testTarget(
            name: "ServerTests",
            dependencies: ["Server"],
            path: "Tests/ServerTests"
        ),
    ]
)
