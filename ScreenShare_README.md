# Screen Share Integration


## Add Broadcast Upload Extension

You need to create a Broadcast Upload Extension to enable the screen sharing process. To do that,

open your project, go to **Xcode -> File -> Target... ->** 

![create_broadcast_upload_extension](https://storage.googleapis.com/cpass-sdk/assets/screenshots/iOS/screenshare_1.png)

Select **Broadcast Upload Extension** and click on **Next**

![select_broadcast_upload_extension](https://storage.googleapis.com/cpass-sdk/assets/screenshots/iOS/screenshare_2.png)

Fill the **Product name** and other info, uncheck **Include UI Extension**, and click **Finish**.

![broadcast_upload_extension_info](https://storage.googleapis.com/cpass-sdk/assets/screenshots/iOS/screenshare_3.png)

Activate the Extension

![activate_broadcast_upload_extension](https://storage.googleapis.com/cpass-sdk/assets/screenshots/iOS/screenshare_4.png)

Xcode automatically creates the Extension folder, which contains the **SampleHandler.swift** file.

**NOTE: Please set deployment target for Broadcast Upload Extension same as of your main app.**


## Add JioMeet Screen Share SDK

Go to your Podfile. Add `JioMeetScreenShareSDK_iOS` pod for your newly created broadcast upload extension and run `pod install --repo-update --verbose` command to install the SDK.

```ruby
target 'ScreenShareExtension' do
	use_frameworks!
	pod 'JioMeetScreenShareSDK_iOS', '~> 2.6'
end
```

**NOTE: `ScreenShareExtension` is name of target you fill while creating `Broadcast Upload Extension`**


## Enable App Groups

You need to enable app groups for your main app and screenshare extension. Please follow guide from below link.
[https://developer.apple.com/documentation/xcode/configuring-app-groups](https://developer.apple.com/documentation/xcode/configuring-app-groups)

[https://www.appcoda.com/app-group-macos-ios-communication/](https://www.appcoda.com/app-group-macos-ios-communication/)


## Edit `SampleHandler.swift` file.

Go to your `SampleHandler.swift` file. Replace the whole file content with content below.

**NOTE: Please change `YOUR_APP_GROUP_NAME_IDENTIFIER` with app group you created in above step.**

```swift
import ReplayKit
import JioMeetScreenShareSDK

class SampleHandler: JMScreenShareHandler {
    override func getAppGroupsIdentifier() -> String {
        return "YOUR_APP_GROUP_NAME_IDENTIFIER"
    }
}
```


## Main App Changes

You need to provide both your app-group and screen share extension bundle identifier to JioMeet UI SDK. Please use `JMUIKit` class `appGroupName` and `screenShareExtensionBundleIdentifier` static variables to provide this info.

```swift
JMUIKit.appGroupName = "YOUR_APP_GROUP_NAME_IDENTIFIER"
JMUIKit.screenShareExtensionBundleIdentifier = "BROADCAST_UPLOAD_EXTENSION_IDENTIFIER"
```
