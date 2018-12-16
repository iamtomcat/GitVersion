# GitVersion

This is meant to copy the build number pattern described in, https://blog.twitch.tv/ios-versioning-89e02f0a5146.

This pattern is `<date after closer epoch in minutes>.<decimal of git hash>`.

```text
Eg: 2861.410204888
```

This allows us to not have to remember to bump the build number and encodes what commit the application is currently built off of.