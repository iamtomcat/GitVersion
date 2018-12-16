import Foundation
import GitVersionKit

let version = GitRunner.run()
let decimal = GitVersion.decimalFromHex(version)

let date = Date().dateSinceCustomEpoch()

if let info = InfoSetter.getPlist() {
  info.setValue("\(Int(date)).\(decimal)", forKey: "CFBundleVersion")
  print(info)
  InfoSetter.setPlist(info)
}
