//
//  WriteHeader.swift
//  GitVersionKit
//
//  Created by Tom Clark on 2019-03-28.
//

import Foundation

public struct WriteHeader {
  private static func getTextForHeader(_ shortVersion: String, _ version: String, _ prefix: String) -> String {
    return """
      #define \(prefix)BundleShortVersionString \(shortVersion)
      #define \(prefix)BundleVersion \(version)
    """
  }

  public static func writeHeaderToPath(_ path: String, withShortVersion short: String, withVersion version: String, withPrefix prefix: String) throws {
    let text = getTextForHeader(short, version, prefix)
    try text.write(toFile: path, atomically: false, encoding: .utf8)
  }
}
