//
//  GitRunner.swift
//  GitVersionKit
//
//  Created by Tom Clark on 2018-12-16.
//

import Foundation

public struct GitVersion {
  /// Converts a git hash string to decimal
  /// - Parameter gitHash: hexidecmal representation of version from git
  /// - Precondition: gitHash length must be 7
  public static func decimalFromHex(_ gitHash: String) -> UInt32 {
    precondition(gitHash.count == 7, "Git hash length not 7")
    guard let value = UInt32(gitHash, radix: 16) else {
      return 0
    }
    return value
  }

  /// Converts decimal value from hexToDecimal back into hex
  /// - Parameters version: decimal representation of version to convert back to hex
  public static func hexFromDecimalVersion(_ version: uint32) -> String {
    return String(version, radix: 16)
  }
}
