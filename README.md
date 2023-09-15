# JioMeetCore UI Demo

## Prerequisites

Before getting started with this example app, please ensure you have the following software installed on your machine:

- Xcode 14.2 or later.
- Swift 5.0 or later.
- An iOS device or emulator running iOS 13.0 or later.

## Integration Steps

### Add SDK

Please add below pod to your Podfile and run command `pod install --repo-update`.

```ruby
pod 'JioMeetUIKit_iOS', '~> 2.0'
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
