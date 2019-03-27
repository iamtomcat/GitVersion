//
//  GitVersionKit.swift
//  GitVersionKit
//
//  Created by Tom Clark on 2019-03-28.
//

import Foundation

public struct GitVersionWithDate {
  let version: uint32
  let timeSince: TimeInterval

  public init() {
    let hash = GitRunner.run()
    let decimal = GitVersion.decimalFromHex(hash)

    self.version = decimal
    self.timeSince = Date().dateSinceCustomEpoch()
  }

  public init(versionString: String) {
    let parts = versionString.split(separator: ".")

    self.timeSince = TimeInterval(String(parts[0])) ?? 0
    self.version = uint32(String(parts[1])) ?? 0
  }

  public var date: String {
    let date = Date(timeInterval: timeSince * 60, since: Date.customEpoch!)
    return date.debugDescription
  }

  public var hash: String {
    return GitVersion.hexFromDecimalVersion(self.version)
  }

  public var formattedValue: String {
    return "\(Int(timeSince)).\(version)"
  }
}
