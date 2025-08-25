import PackageDescription

let package = Package(
    name: "ScalarEngine",
    pkgConfig: "ScalarEngine",
    providers: [
        .brew(["ScalarEngine"])
    ]
)