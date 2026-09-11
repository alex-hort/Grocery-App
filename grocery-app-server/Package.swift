// swift-tools-version:6.2
import PackageDescription

let package = Package(
    name: "grocery-app-server",
    platforms: [
       .macOS(.v13)
    ],
    dependencies: [
        .package(url: "https://github.com/vapor/vapor.git", from: "4.76.0"),
        .package(url: "https://github.com/vapor/jwt.git", from: "5.0.0"),
        .package(url: "https://github.com/vapor/fluent.git", from: "4.0.0"),
        .package(url: "https://github.com/vapor/fluent-postgres-driver.git", from: "2.0.0"),
        .package(url: "https://github.com/apple/swift-nio.git", from: "2.65.0"),
        .package(url: "https://github.com/alex-hort/GroceryAppSharedPM.git", branch: "main")
    ],
    
    targets: [
        .executableTarget(
            name: "grocery-app-server",
            dependencies: [
                .product(name: "Vapor", package: "vapor"),
                .product(name: "Fluent", package: "fluent"),
                .product(name: "JWT", package: "jwt"),
                .product(name: "GroceryAppSharedDTO", package: "GroceryAppSharedPM"),
                .product(name: "FluentPostgresDriver", package: "fluent-postgres-driver"),
            ],
            swiftSettings: swiftSettings
        ),
        .testTarget(
            name: "grocery-app-serverTests",
            dependencies: [
                .target(name: "grocery-app-server"),
                .product(name: "VaporTesting", package: "vapor"),
            ],
            swiftSettings: swiftSettings
        )
    ]
)

var swiftSettings: [SwiftSetting] { [
    .enableUpcomingFeature("ExistentialAny"),
    .enableUpcomingFeature("InternalImportsByDefault"),
    .enableUpcomingFeature("MemberImportVisibility"),
    .enableUpcomingFeature("InferIsolatedConformances"),
    .enableUpcomingFeature("ImmutableWeakCaptures"),
] }
