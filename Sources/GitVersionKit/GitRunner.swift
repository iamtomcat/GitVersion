//
//  GitRunner.swift
//  GitVersionKit
//
//  Created by Tom Clark on 2018-12-16.
//

import Foundation

public struct GitRunner {
  public static func run() -> String {
    #if os(OSX)
      return GitRunner.runOSX()
    #elseif os(Linux)
      return GitRunner.runLinux()
    #endif
  }

  private static func runLinux() {
    fatalError("Needs to be setup")
  }

  private static func runOSX() -> String {
    guard #available(OSX 10.13, *)  else {
      fatalError("MacOS Version not supported")
    }

    var output = [String]()

    let process = Process()
    process.arguments = ["rev-parse", "--short=7", "--verify", "HEAD"]

    // Gets the path to the current file so that the command can be run in current directory instead of derivedData
    let f = #file.split(separator: "/").dropLast().joined(separator: "/")
    process.currentDirectoryURL = URL(fileURLWithPath: "/" + f, isDirectory: true)

    process.executableURL = URL(fileURLWithPath: "/usr/local/bin/git")
    let outpipe = Pipe()
    process.standardOutput = outpipe

    do {
      try process.run()
    } catch {
      print("Error is: ", error)
      exit(1)
    }

    let outdata = outpipe.fileHandleForReading.readDataToEndOfFile()
    if var string = String(data: outdata, encoding: .utf8) {
      string = string.trimmingCharacters(in: .newlines)
      output = string.components(separatedBy: "\n")
    }

    process.waitUntilExit()

    return output.first ?? ""
  }
}
