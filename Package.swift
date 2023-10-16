// swift-tools-version:5.3
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
        .binaryTarget(
          name: "PinwheelSDK",
          path: "PinwheelSDK.xcframework"
        )
        .testTarget(
            name: "PinwheelSDK_Tests",
            dependencies: ["PinwheelSDK"],
            path: "Example/Tests"
        )
    ]
)
