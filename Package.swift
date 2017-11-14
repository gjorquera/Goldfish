// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "Goldfish",
  dependencies: [
    .package(url: "https://github.com/ReactiveX/RxSwift.git", from: "4.0.0"),
  ],
  targets: [
    .target(name: "Goldfish", dependencies: ["GoldfishCore"]),
    .target(name: "GoldfishCore", dependencies: ["RxSwiftExt"]),
    .target(name: "RxSwiftExt", dependencies: ["RxSwift"]),
    .testTarget(name: "GoldfishCoreTests", dependencies: ["GoldfishCore", "RxTest"]),
    .testTarget(name: "RxSwiftExtTests", dependencies: ["RxSwiftExt", "RxTest"]),
  ]
)
