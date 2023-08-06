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
        .package(url: "https://github.com/apple/swift-argument-parser", from: "1.2.2"),
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
                url: "https://github.com/calda/SwiftFormat/releases/download/0.52-beta-2/SwiftFormat.artifactbundle.zip",
                checksum: "0cfa2c39a1d5eb7dd5d129f1eb0d525971bedac47d2864022d4f29a54e3cd0aa"),
        .binaryTarget(
            name: "SwiftLintBinary",
            url: "https://github.com/realm/SwiftLint/releases/download/0.52.4/SwiftLintBinary-macos.artifactbundle.zip",
            checksum: "8a8095e6235a07d00f34a9e500e7568b359f6f66a249f36d12cd846017a8c6f5"),
    ]
)
