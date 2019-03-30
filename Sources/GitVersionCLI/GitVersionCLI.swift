import Foundation
import Guaka
import GitVersionKit

public class GitVersionCLI {
  let cli: Command

  let setVersion = Flag(longName: "path", value: "./version.h", description: "Path to write header file with versions")
  let setPrefix = Flag(longName: "prefix", value: "GV", description: "Path to write header file with versions")

  func processVersion() {
    let command = Command(usage: "version") { _, args in
      guard let first = args.first, args.count > 0 else {
        print("Need to provide version string")
        return
      }
      let version = GitVersionWithDate(versionString: first)

      print("Hash:", version.hash, "Date:", version.date)
    }

    self.cli.add(subCommand: command)
  }

  public init() {
    let version = GitVersionWithDate()

    self.cli = Command(usage: "GitVersion", flags: [setVersion]) { flags, _ in
      print("Version is", version.formattedValue)

      let err: Error?
      if let path = flags.getString(name: "path"), let prefix = flags.getString(name: "prefix") {
        do {
          try WriteHeader.writeHeaderToPath(path, withShortVersion: "0.1.0", withVersion: version.formattedValue, withPrefix: prefix)
          err = nil
        } catch {
          err = error
        }
      } else {
        err = nil
      }

      if let error = err {
        print("Error writing file:", error)
      } else {
        let file = (flags.getString(name: "path") ?? "")
        print("Wrote to file", file)
      }
    }

    processVersion()
  }

  public func execute() {
    cli.execute()
  }
}


//let subCommand = Command(usage: "plist") { _, _ in
//  let plist = InfoSetter.getPlistAtPath("TestAssets/Info.plist")
//  print("plist is", plist!, InfoSetter.getPathToPlist())
//}
//
//command.add(subCommand: subCommand)

