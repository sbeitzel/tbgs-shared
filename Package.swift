// swift-tools-version:5.5

import PackageDescription

let exclude = [String]()

let package = Package(
    name: "tbgs-shared",
    platforms: [.iOS(.v13), .macOS(.v10_15)],
    products: [
        .library(name: "TBGSLib", targets: ["TBGSLib"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "TBGSLib", dependencies: [], exclude: exclude),
        .testTarget(
            name: "TBGSLibTests",
            dependencies: ["TBGSLib"]),
    ]
)
