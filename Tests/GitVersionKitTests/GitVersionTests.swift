//
//  GitVersionTests.swift
//  ios-git-versionTests
//
//  Created by Tom Clark on 2018-12-16.
//

import XCTest
import class Foundation.Bundle
@testable import GitVersionKit

//2f7f359
//49804121

final class GitVersionTests: XCTestCase {
  func testHexToDecimal_validHex_returns49804121() {
    let dec = GitVersion.decimalFromHex("2f7f359")
    XCTAssertEqual(dec, 49804121)
  }

  func testDecimalHex_validDecimal_returns2f7f359() {
    let hex = GitVersion.hexFromDecimalVersion(49804121)
    XCTAssertEqual(hex, "2f7f359")
  }

  static var allTests = [
    ("testHexToDecimal_validHex_returns49804121", testHexToDecimal_validHex_returns49804121),
    ("testDecimalHex_validDecimal_returns2f7f359", testDecimalHex_validDecimal_returns2f7f359)
  ]
}
