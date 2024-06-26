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
                url: "https://github.com/calda/SwiftFormat/releases/download/0.54-beta-5/SwiftFormat.artifactbundle.zip",
                checksum: "7447986db45a51164d23672c07f971406a4c0589b0c423fcb85e95ed8f8e7e48"),
        
            .binaryTarget(
                name: "SwiftLintBinary",
                url: "https://github.com/realm/SwiftLint/releases/download/0.53.0/SwiftLintBinary-macos.artifactbundle.zip",
                checksum: "03416a4f75f023e10f9a76945806ddfe70ca06129b895455cc773c5c7d86b73e"),
    ]
)
