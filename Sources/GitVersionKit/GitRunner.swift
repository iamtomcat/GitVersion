//
//  GitRunner.swift
//  GitVersionKit
//
//  Created by Tom Clark on 2018-12-16.
//

import Foundation
import Files

public struct GitRunner {
  public static func run() -> String {
    return GitRunner.runOSX()
  }

  private static func runOSX() -> String {
    guard #available(OSX 10.13, *)  else {
      fatalError("MacOS Version not supported")
    }

    var output = [String]()

    let process = Process()
    process.arguments = ["rev-parse", "--short=7", "--verify", "HEAD"]

    // Gets the path to the current file so that the command can be run in current directory instead of derivedData
    process.currentDirectoryURL = URL(fileURLWithPath: Folder.current.path, isDirectory: true)

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
