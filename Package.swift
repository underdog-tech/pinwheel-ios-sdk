import PackageDescription

let package = Package(
    name: "PinwheelSDK",
    products: [
        .library(
            name: "PinwheelSDK",
            targets: ["PinwheelSDK"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "PinwheelSDK",
            dependencies: []),
        .testTarget(
            name: "PinwheelSDK_Tests",
            dependencies: ["PinwheelSDK"]),
    ]
)
