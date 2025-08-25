// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "Scalar",
    platforms: [
        .macOS(.v13)
    ],
    products: [
        .executable(
            name: "Scalar",
            targets: ["Scalar"]
        )
    ],
    targets: [
        .executableTarget(
            name: "Scalar",
            path: "Sources/Scalar"
        )
    ]
)