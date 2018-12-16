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
      print("Path is:", path)
      return NSDictionary(contentsOfFile: path)
    }
    let absolutePath = Folder.current.path + path
    print("AbsolutePath is:", absolutePath)

    return NSDictionary(contentsOfFile: absolutePath)
  }

  public static func getPlistNamed(_ plist: String = "Info") -> NSDictionary? {
    let path = InfoSetter.filePathWithFileName(plist)
    let plistValues = InfoSetter.getPlistAtPath(path)
    return plistValues
  }

  public static func setPlist(_ plist: NSDictionary, withName name: String = "Info", atPath path: String? = nil) {
    if let path = path {
      writePlist(plist: plist, path: path)
    } else {
      let path = InfoSetter.filePathWithFileName(name)
      writePlist(plist: plist, path: path)
    }
  }

  private static func writePlist(plist: NSDictionary, path: String) {
    guard #available(OSX 10.13, *) else {
      return
    }
    do {
      try plist.write(to: URL(fileURLWithPath: path))
    } catch {
      print(error)
    }
  }
}
