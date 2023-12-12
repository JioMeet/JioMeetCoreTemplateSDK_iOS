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
   - [Orientation](#orientation)
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
10. [Screen Share Integration](#screen-share-integration)
    - [Add Broadcast Upload Extension](#add-broadcast-upload-extension)
    - [Add JioMeet Screen Share SDK](#add-jiomeet-screen-share-sdk)
    - [Enable App Groups](#enable-app-groups)
    - [Edit SampleHandler file](#edit-samplehandler-file)
    - [Main App Changes](#main-app-changes)
11. [Troubleshooting](#troubleshooting)

## Introduction

In this documentation, we'll guide you through the process of installation, enabling you to enhance your iOS app with Jiomeet's real-time communication capabilities swiftly and efficiently. Let's get started on your journey to creating seamless communication experiences with Jiomeet Template UI!

---

## Features

In Jiomeet Template UI, you'll find a range of powerful features designed to enhance your iOS application's communication and collaboration capabilities. These features include:

1. **Voice and Video Calling**: Enjoy high-quality, real-time audio and video calls with your contacts.

2. **Participant Panel**: Manage and monitor participants in real-time meetings or video calls for a seamless user experience.

3. **Group Conversation**: Easily engage in text-based conversations with multiple participants in one chat group.

4. **Virtual Background**: Customize your video conferencing environment with various background options .

5. **Whiteboard/Screen Share:** Collaborate seamlessly with screen sharing and digital whiteboard capabilities.

6. **Watermark:** JioMeet watermark to be present in all meetings. However, it is configurable.

7. **Livestream:** It will enable users to broadcast their meetings and presentations in real time.

8. **Reactions:** It will provide users with a non-verbal means of expressing emotions and feedback during meetings.

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

### Orientation 

Currently SDK support portarait orientation for the iPhone and landscape for the iPad. If your app supports multiple orientation, please lock down orientation when you show the SDK View.

## Integration Steps

### Add SDK

Please add below pod to your Podfile and run command `pod install --repo-update --verbose`.

```ruby
pod 'JioMeetUIKit_iOS', '~>2.7'
```

Participant Panel, Chat View, Virtualbackground and Reactions are additional seperate frameworks. If you want to include them in your app, please enable below flags and add respective pods in podfile

For Participant Panel View

```swift
JMUIKit.isParticipantPanelEnabled = true
pod 'JioMeetParticipantPanelSDK_iOS', '~>2.7'
```

For Chat View

```swift
JMUIKit.isChatViewEnabled = true
pod 'JioMeetChatUIKit_iOS', '~>2.7'
```

For Virtual Background

```swift
JMUIKit.isVirtualBackgroundEnabled = true
pod 'JioMeetVBGUIKit_iOS', '~>2.7'
```

For Reactions

```swift
JMUIKit.isReactionsEnabled = true
pod 'JioMeetReactions_iOS', '~>2.7'
```

JioMeetUIKit has many optional features which you can enable according to your requirement. Please check below snippet.

```swift
// Enable White Board feature. You can ignore it if you don't want to use Whiteboard

JMUIKit.isWhiteboardEnabled = true

// Enable Start and Stop Recording option. You can ignore if you don't want to handle recording from app side

JMUIKit.isRecordingEnabled = true

// Enable More Settings (Hand raise, Share, Audio only mode etc). You can ignore if you don't want more settings 

JMUIKit.isMoreFeaturesEnabled = true

// Enable Audio only mode feature. You can ignore if you don't want audio only mode feature 

JMUIKit.isAudioOnlyModeFeatureEnabled = true

// Enable Reactions feature. You can ignore if you don't want reactions feature 

JMUIKit.isReactionsEnabled = true

// Enable Live stream feature. You can ignore if you don't want live stream feature 

JMUIKit.isLiveStreamEnabled = true


// Enable Entry/Exit Chime. You can ignore if you don't want to use this feature. Please provide path for Entry/Exit Chime audio files if you enable this feature

JMUIKit.isEntryExitChimeEnabled = true

JMUIKit.entryChimeSoundPath = Bundle.main.path(forResource: "LOCAL_FILE_NAME", ofType: "mp3") ?? ""

JMUIKit.exitChimeSoundPath = Bundle.main.path(forResource: "LOCAL_FILE_NAME", ofType: "mp3") ?? ""

```

JioMeetUIKit also have some other configuration settings to disable existing features according to your requirement. Please check below snippet.

```swift

// You can disable meeting title label by using below flag 

JMUIKit.showMeetingTitle = false

// You can disable meeting duration label by using below flag 

JMUIKit.showMeetingTimer = false

// You can disable meeting info icon by using below flag 

JMUIKit.showMeetingInfo = false

// You can disable switching audio mode option (Speaker, Earphones, Bluetooth etc) by using below flag 

JMUIKit.showAudioOptions = false

// You can disable flip camera option by using below flag 

JMUIKit.enableFlipCamera = false

// You can disable network indicator option by using below flag 

JMUIKit.showConnectionStateIndicator = false

// You can disable thank you screen by using below flag 

JMUIKit.showThankYouScreen = false

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


## Screen Share Integration


### Add Broadcast Upload Extension

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


### Add JioMeet Screen Share SDK

Before installing pod please enable below flag to get screen share option in more settings

```swift
JMUIKit.isScreenShareEnabled = true
```

Go to your Podfile. Add `JioMeetScreenShareSDK_iOS` pod for your newly created broadcast upload extension and run `pod install --repo-update --verbose` command to install the SDK.

```ruby
target 'ScreenShareExtension' do
    use_frameworks!
    pod 'JioMeetScreenShareSDK_iOS', '~>2.7'
end
```

**NOTE: `ScreenShareExtension` is name of target you fill while creating `Broadcast Upload Extension`**


### Enable App Groups

You need to enable app groups for your main app and screenshare extension. Please follow guide from below link.
[https://developer.apple.com/documentation/xcode/configuring-app-groups](https://developer.apple.com/documentation/xcode/configuring-app-groups)

[https://www.appcoda.com/app-group-macos-ios-communication/](https://www.appcoda.com/app-group-macos-ios-communication/)


### Edit `SampleHandler` file.

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


### Main App Changes

You need to provide both your app-group and screen share extension bundle identifier to JioMeet UI SDK. Please use `JMUIKit` class `appGroupName` and `screenShareExtensionBundleIdentifier` static variables to provide this info.

```swift
JMUIKit.appGroupName = "YOUR_APP_GROUP_NAME_IDENTIFIER"
JMUIKit.screenShareExtensionBundleIdentifier = "BROADCAST_UPLOAD_EXTENSION_IDENTIFIER"
```

## Troubleshooting

Facing any issues while integrating or installing the JioMeet Template UI Kit please connect with us via real time support present in jiomeet.support@jio.com or https://jiomeetpro.jio.com/contact-us
