// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftStyle",
    platforms: [.macOS(.v10_13)],
    products: [
        .plugin(name: "FormatSwift", targets: ["FormatSwift"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser", from: "1.2.3"),
    ],
    targets: [
        .plugin(
            name: "FormatSwift",
            capability: .command(
                intent: .custom(
                    verb: "format",
                    description: "Formats Swift source files according to the Swift Style Guide"),
                permissions: [
                    .writeToPackageDirectory(reason: "Format Swift source files"),
                ]),
            dependencies: [
                "SwiftFormatTool",
                "SwiftFormat",
                "SwiftLintBinary",
            ]),
        
            .executableTarget(
                name: "SwiftFormatTool",
                dependencies: [
                    .product(name: "ArgumentParser", package: "swift-argument-parser"),
                ],
                resources: [
                    .process("styleguide.swiftformat"),
                    .process("swiftlint.yml"),
                ]),
        
            .binaryTarget(
                name: "SwiftFormat",
                url: "https://github.com/calda/SwiftFormat/releases/download/0.56-beta-8/SwiftFormat.artifactbundle.zip",
                checksum: "32e21fd84bffcc9154c7d80ff2173fb1d6a3dbd740e4bf6a151b6e33e0cced3d"),
        
            .binaryTarget(
                name: "SwiftLintBinary",
                url: "https://github.com/realm/SwiftLint/releases/download/0.55.1/SwiftLintBinary-macos.artifactbundle.zip",
                checksum: "722a705de1cf4e0e07f2b7d2f9f631f3a8b2635a0c84cce99f9677b38aa4a1d6"),
    ]
)
