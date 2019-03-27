//
//  WriteHeader.swift
//  GitVersionKit
//
//  Created by Tom Clark on 2019-03-28.
//

import Foundation

public struct WriteHeader {
  private static func getTextForHeader(_ shortVersion: String, _ version: String) -> String {
    return """
      #define TWBundleShortVersionString \(shortVersion)
      #define TWBundleVersion \(version)
    """
  }

  public static func writeHeaderToPath(_ path: String, withShortVersion short: String, withVersion version: String) throws {
    let text = getTextForHeader(short, version)
    try text.write(toFile: path, atomically: false, encoding: .utf8)
  }
}
