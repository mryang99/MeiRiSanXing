import PackageDescription
let package = Package(
    name: "MeiRiSanXing",
    platforms: [.iOS(.v18), .macOS(.v15)],
    products: [
        .library(name: "MeiRiSanXing", targets: ["MeiRiSanXing"]),
    ],
    targets: [
        .target(name: "MeiRiSanXing", path: "Sources/MeiRiSanXing"),
        .testTarget(name: "MeiRiSanXingTests", dependencies: ["MeiRiSanXing"], path: "Tests/MeiRiSanXingTests"),
    ]
)
