// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "SwiftValidators",
    platforms: [
        .iOS(.v9)
    ],
    products: [
        .library(name: "SwiftValidators",
                 targets: ["SwiftValidators"]),
    ],
    targets: [
        .target(name: "SwiftValidators",
                dependencies: [],
                path: "SwiftValidators"
        )
    ]
)

