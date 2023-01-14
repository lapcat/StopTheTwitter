# StopTheTwitter

StopTheTwitter is an app for macOS 10.15 Catalina and later that stops "Open in the Twitter app" from appearing at the top of `twitter.com` web pages in Safari when the official Twitter Mac app is installed.

Announcement: [Stop 'Open in the Twitter app' in Safari Catalina](https://lapcatsoftware.com/articles/universal-links.html)

## Installing

1. Download the [latest release](https://github.com/lapcat/StopTheTwitter/releases/latest).
2. Unzip the downloaded `.zip` file.
3. Move `StopTheTwitter.app` to the Applications folder.
4. Open `StopTheTwitter.app`.
5. Quit `StopTheTwitter.app`.
6. You may need to logout and login to ensure it starts working.

## Uninstalling

1. Move `StopTheTwitter.app` to the Trash.

## Known Issues

- StopTheTwitter may prevent App Store from updating the Twitter app, because they have the same bundle identifier.

-  When the real Twitter app is not open, the fake app receives push notifications from Twitter, but the fake app doesn't have any knowledge or access to Twitter API, so it can't handle the notification actions. If you do anything other than close a Twitter push notification, then the fake app simply opens the real Twitter app and quits. Fortunately, when the real Twitter app is open, it handles push notifications itself.

## Building

Building StopTheTwitter from source requires Xcode 11 or later.

Before building, you need to create a file named `DEVELOPMENT_TEAM.xcconfig` in the project folder (the same folder as `Shared.xcconfig`). This file is excluded from version control by the project's `.gitignore` file, and it's not referenced in the Xcode project either. The file specifies the build setting for your Development Team, which is needed by Xcode to code sign the app. The entire contents of the file should be of the following format:
```
DEVELOPMENT_TEAM = [Your TeamID]
```

## Author

[Jeff Johnson](https://lapcatsoftware.com/)

To support the author, you can [PayPal.Me](https://www.paypal.me/JeffJohnsonWI) or buy the Safari extension StopTheMadness in the [Mac App Store](https://apps.apple.com/app/stopthemadness/id1376402589?mt=12).

## Copyright

StopTheTwitter is Copyright © 2020 Jeff Johnson. All rights reserved.

## License

See the [LICENSE.txt](LICENSE.txt) file for details.
