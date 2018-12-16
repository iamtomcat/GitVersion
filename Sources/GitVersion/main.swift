import Foundation
import GitVersionKit

var path: String?
if let index = CommandLine.arguments.firstIndex(of: "-p"), CommandLine.arguments.count > index + 1 {
  path = CommandLine.arguments[index+1]
}

let version = GitRunner.run()
let decimal = GitVersion.decimalFromHex(version)

let date = Date().dateSinceCustomEpoch()

if let path = path, let plist = InfoSetter.getPlistAtPath(path) {
  plist.setValue("\(Int(date)).\(decimal)", forKey: "CFBundleVersion")
  InfoSetter.setPlist(plist, withName: "Info.plist", atPath: path)
} else if let plist = InfoSetter.getPlistNamed() {
  plist.setValue("\(Int(date)).\(decimal)", forKey: "CFBundleVersion")
  InfoSetter.setPlist(plist)
}

