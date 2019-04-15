import Foundation
import Guaka
import GitVersionKit

public class GitVersionCLI {
  let cli: Command

  let setVersion = Flag(longName: "path", value: "./version.h", description: "Path to write header file with versions")
  let setPrefix = Flag(longName: "prefix", value: "GV", description: "Prefix for variable for versioning")
  let shortVersion = Flag(longName: "shortVersion", type: String.self, description: "Short version string")

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

    self.cli = Command(usage: "GitVersion", flags: [setVersion, setPrefix, shortVersion]) { flags, _ in
      guard let shortVersion = flags.getString(name: "shortVersion") else {
        print("Short Version not defined")
        return
      }

      print("Version is", version.formattedValue)

      let err: Error?
      if let path = flags.getString(name: "path"), let prefix = flags.getString(name: "prefix") {
        do {
          try WriteHeader.writeHeaderToPath(path, withShortVersion: shortVersion, withVersion: version.formattedValue, withPrefix: prefix)
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
