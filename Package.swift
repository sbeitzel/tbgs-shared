// swift-tools-version:5.5

import PackageDescription

let exclude = [String]()

let package = Package(
    name: "tbgs-shared",
    platforms: [
        .macOS(.v12), .iOS(.v15)
    ],
    products: [
        .library(name: "TBGSLib", type: .dynamic, targets: ["TBGSLib"]),
    ],
    dependencies: [],
    targets: [
        .target(name: "TBGSLib", dependencies: [], exclude: exclude)
    ]
)
