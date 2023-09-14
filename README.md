# JioMeetCore UI Demo

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

Join meeting by calling `joinMeeting` method by passing meeting data.

```swift
meetingView.joinMeeting(
    meetingID: meetingID,
    meetingPIN: meetingPIN,
    userDisplayName: userDisplayName,
    hostToken: hostToken,
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
