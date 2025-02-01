// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

extension Product {
    public static func singleLibrary(name: String) -> Product {
        .library(name: name, targets: [name])
    }
    
    public static func singleExuctable(name: String) -> Product {
        .executable(name: name, targets: [name])
    }
}

let package = Package(
    name: "BoxedContent",
    products: [
        .singleLibrary(name: "BoxedContent"),
        .singleExuctable(name: "Client")
    ],
    targets: [
        .executableTarget(
            name: "Client",
            dependencies: ["BoxedContent"]
        ),
        .target(
            name: "BoxedContent"),
        .testTarget(
            name: "BoxedContentTests",
            dependencies: ["BoxedContent"]
        ),
    ]
)
