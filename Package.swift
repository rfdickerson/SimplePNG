import PackageDescription

let package = Package(
    name: "SimplePNG",
    dependencies: [
        .Package(url: "https://github.com/rfdickerson/CPNG", majorVersion: 0, minor: 0)
    ]
)
