//
//  Date+Extensions.swift
//  GitVersionKit
//
//  Created by Tom Clark on 2018-12-16.
//

import Foundation

extension Date {
  public func dateSinceCustomEpoch() -> TimeInterval {
    var dateComponents = DateComponents()
    dateComponents.year = 2018
    dateComponents.day = 1
    dateComponents.month = 1
    dateComponents.timeZone = TimeZone(abbreviation: "GMT")

    if let date = Calendar(identifier: .gregorian).date(from: dateComponents) {
      return self.timeIntervalSince(date) / 60
    }
    return 0
  }
}
