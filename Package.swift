// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "FormKit",
    platforms: [
        .iOS(.v9)
    ],
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages. 
        .library(
            name: "FormKit",
            targets: ["FormKit"]),
    ],
    dependencies: [
      .package(url: "https://github.com/ra1028/DifferenceKit.git", from: Version("1.1.5"))
      //.package(url: "https://github.com/devxoul/Then", from: Version("2.6.0"))
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "FormKit",
            dependencies: [
              "DifferenceKit"
        ]),
        .testTarget(
            name: "FormKitTests",
            dependencies: ["FormKit"]),
    ]
)
