import PackageDescription
let package = Package(
  name: "foo",
  dependencies: [
    .Package(url: "https://github.com/Danappelxx/SwiftMongoDB", majorVersion: 0, minor: 5)
  ]
)