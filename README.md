# JioMeet Template UI Quickstart

## Table of Contents

1. [Introduction](#introduction)
2. [Features](#features)
3. [Prerequisites](#prerequisites)
4. [Setup](#setup)
   - [Register on JioMeet Platform](#register-on-jiomeet-platform)
   - [Get Your Application Keys](#get-your-application-keys)
   - [Get Your JioMeet Meeting ID and PIN](#get-your-jiomeet-meeting-id-and-pin)
5. [Project Settings](#project-settings)
   - [Info.plist Changes](#infoplist-changes)
   - [Enable Background Mode](#enable-background-mode)
   - [Enable Audio Video Permissons](#enable-audio-video-permissons)
6. [Integration Steps](#integration-steps)
   - [Add SDK](#add-sdk)
   - [Import SDK](#import-sdk)
   - [Integrate Meeting View](#integrate-meeting-view)
7. [Join Meeting](#join-meeting)
   - [Create Meeting Data](#create-meeting-data)
   - [Create Meeting Configuration](#create-meeting-configuration)
   - [Join Meeting with data and config](#join-meeting-with-data-and-config)
   - [Implement JMMeetingViewDelegate methods](#implement-jmmeetingviewdelegate-methods)
8. [Run Project](#run-project)
9. [Reference Classes](#reference-classes)

# Screen Share Integration

## Table of Contents

1. [Add Broadcast Upload Extension](#add-broadcast-upload-extension)
2. [Add JioMeet Screen Share SDK](#add-jiomeet-screen-share-sdk)
3. [Enable App Groups](#enable-app-groups)
4. [Edit SampleHandler.swift file](#edit-sampleHandler.swift-file)
5. [Main App Changes](#main-app-changes)
6. [Troubleshooting](#troubleshooting)


## Introduction

In this documentation, we'll guide you through the process of installation, enabling you to enhance your iOS app with Jiomeet's real-time communication capabilities swiftly and efficiently. Let's get started on your journey to creating seamless communication experiences with Jiomeet Template UI!

---

## Features

In Jiomeet Template UI, you'll find a range of powerful features designed to enhance your iOS application's communication and collaboration capabilities. These features include:

1. **Voice and Video Calling**: Enjoy high-quality, real-time audio and video calls with your contacts.

2. **Participant Panel**: Manage and monitor participants in real-time meetings or video calls for a seamless user experience.

3. **Group Conversation**: Easily engage in text-based conversations with multiple participants in one chat group.


## Prerequisites

Before getting started with this example app, please ensure you have the following software installed on your machine:

- Xcode 14.2 or later.
- Swift 5.0 or later.
- An iOS device or emulator running iOS 13.0 or later.

## Setup

#### Register on JioMeet Platform:

You need to first register on Jiomeet platform. [Click here to sign up](https://platform.jiomeet.com/login/signUp)

#### Get your application keys:

Create a new app. Please follow the steps provided in the [Documentation guide](https://dev.jiomeet.com/docs/quick-start/introduction) to create apps before you proceed.

#### Get your Jiomeet meeting id and pin

Use the [create meeting api](https://dev.jiomeet.com/docs/JioMeet%20Platform%20Server%20APIs/create-a-dynamic-meeting) to get your room id and password

## Project Settings

### Info.plist Changes

Please add below permissions keys to your `Info.plist` file with proper description.

```swift
<key>NSCameraUsageDescription</key>
<string>Allow access to camera for meetings</string>
<key>NSMicrophoneUsageDescription</key>
<string>Allow access to mic for meetings</string>
```

### Enable Background Mode

Please enable `Background Modes` in your project `Signing & Capibilities` tab. After enabling please check box with option `Audio, Airplay, and Pictures in Pictures`. If you don't enables this setting, your mic will be muted when your app goes to background.

### Enable Audio Video Permissons

Before joining the meeting please check audio video permissons are enabled or not. If not please throw an error to enable both audio and video permissons 

## Integration Steps

### Add SDK

Please add below pod to your Podfile and run command `pod install`.

```ruby
pod 'JioMeetUIKit_iOS', '2.5'
```

To enable paritipant panel we need to set `JMUIKit.isParticipantPanelEnabled = true` and add below pod to your Podfile

```ruby
pod 'JioMeetParticipantPanelSDK_iOS', '2.5'
```

To enable chat we need to set `JMUIKit.isChatViewEnabled = true` and add below pod to your Podfile

```ruby
pod 'JioMeetChatUIKit_iOS', '2.5'
```

To enable chat we need to set `JMUIKit.isVirtualBackgroundEnabled = true` and add below pod to your Podfile

```ruby
pod 'JioMeetVBGUIKit_iOS', '2.5'
```


Also we have other variable to enable features. default values are false

1. Recording : To enable reocrding we need to set 

```ruby
`JMUIKit.isRecordingEnabled = true
```

2. Whiteboard : To enable whiteboard we need to set 

```ruby
`JMUIKit.isRecordingEnabled = true
```

3. Play chime on user join: To enable chime we need to set below paramters
```ruby
    JMUIKit.isEntryExitChimeEnabled = true
    JMUIKit.entryChimeSoundPath = LOCAL_MP3_FILE_PATH
    JMUIKit.exitChimeSoundPath = LOCAL_MP3_FILE_PATH
```

### Import SDK

Please use below import statements

```swift
import JioMeetUIKit
import JioMeetCoreSDK
```

### Integrate Meeting View


Create instance of `JMMeetingView`. 

```swift
private var meetingView = JMMeetingView()
```

Add it to your viewController view. 

```swift
meetingView.translatesAutoresizingMaskIntoConstraints = false
view.addSubview(meetingView)

NSLayoutConstraint.activate([
    meetingView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
    meetingView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
    meetingView.topAnchor.constraint(equalTo: view.topAnchor),
    meetingView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
])
```

## Join Meeting

### Create Meeting Data

First create `JMJoinMeetingData` type object. Following are the properties of this object.

| Property Name | Type  | Description  |
| ------- | --- | --- |
| meetingId | String | Meeting ID of the meeting user is going to join. |
| meetingPin | String | Meeting PIN of the meeting user is going to join. |
| displayName | String | Display Name with which user is going to join the meeting. |

```swift
let joinMeetingData = JMJoinMeetingData(
    meetingId: "9680763133",
    meetingPin: "1tKzt",
    displayName: "John Appleased"
)
```

### Create Meeting Configuration

Create a `JMJoinMeetingConfig` type object. Following are the properties of this object.

| Property Name | Type  | Description  |
| ------- | --- | --- |
| userRole | JMUserRole | Role of the user in the meeting. Possible values are `.host`, `.speaker`, `.audience`. If you are assigning `.host` value, please pass the token in its argument. |
| isInitialAudioOn | Bool | Initial Audio State of the user when user joins the meeting. If meeting is hard muted by a host, initial audio state will be muted and this setting will not take place. |
| isInitialVideoOn | Bool | Initial Video State of the user when user joins the meeting. |

```swift
let joinMeetingConfig = JMJoinMeetingConfig(
    userRole: .host(hostToken: "MD5hQxGAwjW2"),
    isInitialAudioOn: false,
    isInitialVideoOn: false
)
```

### Join Meeting with data and config

After creating `JMJoinMeetingData` and `JMJoinMeetingConfig` objects, call `joinMeeting` method of `JMClient` instance.

Following are the arguments of `joinMeeting` method.

| Argument Name | Type  | Description  |
| ------- | --- | --- |
| meetingData | JMJoinMeetingData | Meeting Data which include meeting id, pin and user display name. |
| config | JMJoinMeetingConfig | Meeting Configuration which include user role, mic and camera initial states. |
| delegate | JMClientDelegate? | A class conforming to `JMClientDelegate` protocol.  |


```swift
meetingView.joinMeeting(
    meetingData: joinMeetingData,
    config: joinMeetingConfig,
    delegate: self
)
```

**Note: Host Token can be nil.**

### Implement JMMeetingViewDelegate methods

Confirm your class with `JMMeetingViewDelegate` protocol and implement its methods

```swift

// Local User has left the meeting
func didLocalUserExitsMeetingView() {
    navigationController?.popViewController(animated: true)
}

// Local User failed to joined the meeting. Please use errorMessage to show any error.
func didLocalUserFailedToJoinMeeting(errorMessage: String) {
    showMeetingJoinError(message: errorMessage)
}

// UI SDK has requested to share meeting. Use meetingID and meetingPin to show any UI you want. For e.g. `UIActivityViewController`
func didRequestToShareMeetingView(meetingID: String, meetingPin: String) {
    showMeetingShareView(meetingID: meetingID, meetingPin: meetingPin)
}

// UI SDK has requested to create meeting share Link.
func didRequestToBuildMeetingShareLink(meetingID: String, meetingPin: String, completion: @escaping ((String) -> Void)) {
    var components = URLComponents()
    components.scheme = "https"
    components.host = "jiomeetpro.jio.com"
    components.path = "/shortener"
    components.queryItems = [
        URLQueryItem(name: "meetingId", value: meetingID),
        URLQueryItem(name: "pwd", value: meetingPin)
    ]
    
    guard let urlString = components.string else { return }
    completion(urlString)
}
```

## Run Project

Run `pod install --repo-update` command. Open JioMeetCoreUIDemo.xcworkspace file.


## Reference Classes

Please check `MeetingScreenViewController` class for integration reference.


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

Go to your Podfile. Add `JioMeetScreenShareSDK_iOS` pod for your newly created broadcast upload extension and run `pod install` command to install the SDK.

```ruby
target 'ScreenShareExtension' do
    use_frameworks!
    pod 'JioMeetScreenShareSDK_iOS', '2.5'
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
    
    let appGroupsIdentifier: String = "YOUR_APP_GROUP_NAME_IDENTIFIER"
    
    override func clearScreenShareDataFromUserDefaults() {
        let currentUserDefaults = UserDefaults(suiteName: appGroupsIdentifier)
        currentUserDefaults?.removeObject(forKey: ScreenShareUserDefaultsKeys.rtcAppIdKey.rawValue)
        currentUserDefaults?.removeObject(forKey: ScreenShareUserDefaultsKeys.rtcRoomIdKey.rawValue)
        currentUserDefaults?.removeObject(forKey: ScreenShareUserDefaultsKeys.rtcTokenKey.rawValue)
        currentUserDefaults?.removeObject(forKey: ScreenShareUserDefaultsKeys.shareUidKey.rawValue)
    }
    
    override func didRequestScreenShareStartData() -> NSDictionary {
        let currentUserDefaults = UserDefaults(suiteName: appGroupsIdentifier)
        let rtcAppId = currentUserDefaults?.value(forKey: ScreenShareUserDefaultsKeys.rtcAppIdKey.rawValue) as? String ?? ""
        let rtcRoomId = currentUserDefaults?.value(forKey: ScreenShareUserDefaultsKeys.rtcRoomIdKey.rawValue) as? String ?? ""
        let rtcToken = currentUserDefaults?.value(forKey: ScreenShareUserDefaultsKeys.rtcTokenKey.rawValue) as? String ?? ""
        let uid = currentUserDefaults?.value(forKey: ScreenShareUserDefaultsKeys.shareUidKey.rawValue) as? String ?? ""
        let dataDictionary : NSDictionary = [
            ScreenShareStrings.rtcAppId.rawValue: rtcAppId,
            ScreenShareStrings.rtcRoomId.rawValue: rtcRoomId,
            ScreenShareStrings.rtcToken.rawValue: rtcToken,
            ScreenShareStrings.shareUid.rawValue: uid,
        ]
        return dataDictionary
    }
    
    override func didRequestScreenShareStopReason() -> String? {
        let currentUserDefaults = UserDefaults(suiteName: appGroupsIdentifier)
        return currentUserDefaults?.value(forKey: ScreenShareUserDefaultsKeys.screenShareStopReason.rawValue) as? String
    }
}
```


## Main App Changes

You need to provide both your app-group and screen share extension bundle identifier to JioMeet UI SDK. Please use `JMUIKit` class `appGroupName` and `screenShareExtensionBundleIdentifier` static variables to provide this info.

```swift
JMUIKit.appGroupName = "YOUR_APP_GROUP_NAME_IDENTIFIER"
JMUIKit.screenShareExtensionBundleIdentifier = "BROADCAST_UPLOAD_EXTENSION_IDENTIFIER"
```

## Troubleshooting

Facing any issues while integrating or installing the JioMeet Template UI Kit please connect with us via real time support present in jiomeet.support@jio.com or https://jiomeetpro.jio.com/contact-us
