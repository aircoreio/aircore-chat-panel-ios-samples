### ChatPanel SDK iOS Samples
The samples in this repository demonstrate how to use the Aircore ChatPanel SDK.  For more information, check out the [getting started guide](https://docs.aircore.io/getting-started/chat-ios-quickstart) or the [API reference](https://docs.aircore.io/ios/chatpanel/api-reference/aircorechatpanel).

#### [SwiftUI Sample](https://github.com/aircoreio/aircore-chat-panel-ios-samples/tree/main/ChatPanel-SwiftUI)
#### [Swift Sample](https://github.com/aircoreio/aircore-chat-panel-ios-samples/tree/main/ChatPanel-UIKit-Swift)
#### [Objective-C Sample](https://github.com/aircoreio/aircore-chat-panel-ios-samples/tree/main/ChatPanel-UIKit-ObjC)

##### Setup
```
git clone https://github.com/aircoreio/aircore-chat-panel-ios-samples.git
```

##### Launch
1. Ensure you have **Xcode 13.3+** installed.
2. Open Finder and navigate to the directory where you checked out the code.
3. For the **Swift** sample, launch `aircore-chat-panel-ios-samples` -> `ChatPanel-UIKit-Swift` -> `ChatPanel-UIKit-Swift.xcodeproj`.
4. For the **Objective-C** sample, launch `aircore-chat-panel-ios-samples` -> `ChatPanel-UIKit-ObjC` -> `ChatPanel-UIKit-ObjC.xcodeproj`.

#### Customization
1. From the Xcode Project Navigator, open the `Info.plist` file.
2. Replace `INSERT_PUBLISHABLE_API_KEY_FROM_DEVELOPER_DASHBOARD` with a Publishable API Key from the developer dashboard.
3. Open `ViewController.swift` for the **Swift** sample, or `ViewController.m` for the **Objective-C** sample.
4. Change these values as per your needs:

##### SwiftUI/Swift  
```swift
let userId = UUID.init().uuidString // Replace with any unique ID that represents your user in your system.
lazy var userName = "User " + userId.prefix(5) // Replace with any name that represents your user in your system.
lazy var userAvatarURL = URL(string: "https://i.pravatar.cc/300?u=" + userId) // Replace with a url for a profile picture that represents your user in your system.
let channel = "sample-app" // Replace with any unique name/id that represents a channel in your system.
```

##### Objective-C  
```objc
NSString *userId = [NSUUID UUID].UUIDString; // Replace with any unique ID that represents your user in your system.
NSString *userName = [NSString stringWithFormat:@"User %@", [userId substringToIndex:5]]; // Replace with any name that represents your user in your system.
NSString *avatarUrl = [NSString stringWithFormat:@"https://i.pravatar.cc/300?u=%@", userId];  // Replace with a url for a profile picture that represents your user in your system.
NSString *const kChannelId = @"sample-app"; // Replace with any unique name/id that represents a channel in your system.
```

##### Running the Sample
1. Choose a simulator or an actual device
2. Tap the ▷ button to run the sample
