//
//  InfoSetter.swift
//  GitVersionKit
//
//  Created by Tom Clark on 2018-12-16.
//

import Foundation
import Files

public struct InfoSetter {
  private static func filePathWithFileName(_ name: String) -> String {
    var path = ""
    Folder.current.makeSubfolderSequence(recursive: true).forEach { folder in
      if folder.containsFile(named: name+".plist") && !folder.path.lowercased().contains("test") {
        path = folder.path + "/" + name + ".plist"
      }
    }
    return path
  }

  public static func getPlistAtPath(_ path: String) -> NSDictionary? {
    if path.hasPrefix(Folder.current.path) {
      return NSDictionary(contentsOfFile: path)
    }
    let absolutePath = Folder.current.path + "/" + path
    return NSDictionary(contentsOfFile: absolutePath)
  }

  public static func getPlistNamed(_ plist: String = "Info") -> NSDictionary? {
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
