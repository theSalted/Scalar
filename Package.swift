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
        .systemLibrary(
            name: "ScalarEngine",
            path: "Sources/ScalarEngine"
        ),
        .executableTarget(
            name: "Scalar",
            dependencies: ["ScalarEngine"],
            path: "Sources/Scalar",
            linkerSettings: [
                .linkedLibrary("c++"),
                .linkedFramework("CoreFoundation"),
                .linkedFramework("CoreGraphics"),
                .linkedFramework("CoreAudio"),
                .linkedFramework("AudioToolbox"),
                .linkedFramework("Foundation"),
                .linkedFramework("AppKit"),
                .linkedFramework("Carbon"),
                .linkedFramework("IOKit"),
                .linkedFramework("ForceFeedback"),
                .linkedFramework("CoreHaptics"),
                .linkedFramework("GameController"),
                .linkedFramework("CoreVideo"),
                .linkedFramework("Metal"),
                .linkedFramework("QuartzCore"),
                .linkedFramework("UniformTypeIdentifiers"),
                .linkedFramework("AVFoundation"),
                .linkedFramework("CoreMedia"),
                .unsafeFlags([
                    "-L/Users/yuhaochen/Developer/Scalar/build/macos-arm64-debug",
                    "-lEngine",
                    "-L/Users/yuhaochen/Developer/Scalar/build/macos-arm64-debug/vcpkg_installed/arm64-osx/lib",
                    "-lSDL3",
                    "-lflecs_static",
                    "-lGameNetworkingSockets_s",
                    "-lprotobuf",
                    "-lcrypto",
                    "-lbgfx",
                    "-lbimg",
                    "-lbx",
                    "-lBulletDynamics",
                    "-lBulletCollision",
                    "-lLinearMath"
                ])
            ]
        )
    ]
)