import PackageDescription

let package = Package(
    name: "Meily-Server", 
    dependencies: [
      .Package(url:"https://github.com/IBM-Swift/Kitura.git", majorVersion: 1),
      .Package(url:"https://github.com/IBM-Swift/HeliumLogger.git", majorVersion: 1)
    ]
)
