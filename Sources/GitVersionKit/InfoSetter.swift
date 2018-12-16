//
//  InfoSetter.swift
//  GitVersionKit
//
//  Created by Tom Clark on 2018-12-16.
//

import Foundation

public struct InfoSetter {
  private static func filePathWithFileName(_ name: String) -> String {
    return FileManager.default.currentDirectoryPath + "/\(name).Plist"
  }

  public static func getPlist(_ plist: String = "Info") -> NSDictionary? {
    let path = InfoSetter.filePathWithFileName(plist)
    let plistValues = NSDictionary(contentsOfFile: path)
    return plistValues
  }

  public static func setPlist(_ plist: NSDictionary, withName name: String = "Info") {
    guard #available(OSX 10.13, *) else {
      return
    }
    let path = InfoSetter.filePathWithFileName(name)

    do {
      try plist.write(to: URL(fileURLWithPath: path))
    } catch {
      print(error)
    }
  }
}
