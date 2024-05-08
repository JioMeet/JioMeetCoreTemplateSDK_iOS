// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "JioMeetUISDKs_iOS",
    defaultLocalization: "en",
    platforms: [.iOS(.v13)],
    products: [
        .library(name: "JMUIFoundation", targets: ["JioMeetUIFoundationTarget"]), 
        .library(name: "JMCoreUIKit", targets: ["JioMeetUIKitTarget"]), 
        .library(name: "JMChatUIKit", targets: ["JioMeetChatUIKitTarget"]), 
        .library(name: "JMParticipantPanelUIKit", targets: ["JioMeetParticipantPanelSDKTarget"]), 
        .library(name: "JMVirtualBackgroundUIKit", targets: ["JioMeetVBGUIKitTarget"]), 
        .library(name: "JMReactionsUIKit", targets: ["JioMeetReactionsTarget"]), 
    ],
    dependencies: [
		.package(
			name: "JioMeetCoreSDK",
			url: "https://github.com/JioMeet/JioMeetCoreSDK_iOS.git",
			.upToNextMajor(from: "3.0.0")
		),
        .package(
			name: "Lottie",
			url: "https://github.com/airbnb/lottie-spm.git",
            .upToNextMajor(from: "4.4.3")
		)
	],
    targets: [
        .binaryTarget(
            name: "JioMeetUIFoundation",
            path: "XCFrameworks/JioMeetUIFoundation.xcframework"
        ),
        .binaryTarget(
            name: "JioMeetUIKit",
            path: "XCFrameworks/JioMeetUIKit.xcframework"
        ),
        .binaryTarget(
            name: "JioMeetChatUIKit",
            path: "XCFrameworks/JioMeetChatUIKit.xcframework"
        ),
        .binaryTarget(
            name: "JioMeetParticipantPanelSDK",
            path: "XCFrameworks/JioMeetParticipantPanelSDK.xcframework"
        ),
        .binaryTarget(
            name: "JioMeetVBGUIKit",
            path: "XCFrameworks/JioMeetVBGUIKit.xcframework"
        ),
        .binaryTarget(
            name: "JioMeetReactions",
            path: "XCFrameworks/JioMeetReactions.xcframework"
        ),
        .target(
			name: "JioMeetUIFoundationTarget",
			dependencies: [
				.target(name: "JioMeetUIFoundation"),
                .product(name: "JioMeetCoreSDK", package: "JioMeetCoreSDK")
			],
			path: "SPMSource/UIFoundationSDK",
			exclude: []
		),
        .target(
			name: "JioMeetUIKitTarget",
			dependencies: [
                .target(name: "JioMeetUIFoundationTarget"),
				.target(name: "JioMeetUIKit"),
                .product(name: "JioMeetCoreSDK", package: "JioMeetCoreSDK")
			],
			path: "SPMSource/CoreUISDK",
			exclude: []
		),
        .target(
			name: "JioMeetChatUIKitTarget",
			dependencies: [
                .target(name: "JioMeetUIFoundationTarget"),
				.target(name: "JioMeetChatUIKit"),
                .product(name: "JioMeetCoreSDK", package: "JioMeetCoreSDK")
			],
			path: "SPMSource/ChatUISDK",
			exclude: []
		),
        .target(
			name: "JioMeetParticipantPanelSDKTarget",
			dependencies: [
                .target(name: "JioMeetUIFoundationTarget"),
				.target(name: "JioMeetParticipantPanelSDK"),
                .product(name: "JioMeetCoreSDK", package: "JioMeetCoreSDK")
			],
			path: "SPMSource/ParticipantsUISDK",
			exclude: []
		),
        .target(
			name: "JioMeetVBGUIKitTarget",
			dependencies: [
                .target(name: "JioMeetUIFoundationTarget"),
				.target(name: "JioMeetVBGUIKit"),
                .product(name: "JioMeetCoreSDK", package: "JioMeetCoreSDK")
			],
			path: "SPMSource/VirtualBackgroundSDK",
			exclude: []
		),
        .target(
			name: "JioMeetReactionsTarget",
			dependencies: [
                .target(name: "JioMeetUIFoundationTarget"),
				.target(name: "JioMeetReactions"),
                .product(name: "JioMeetCoreSDK", package: "JioMeetCoreSDK"),
                .product(name: "Lottie", package: "Lottie"),
			],
			path: "SPMSource/ReactionsUISDK",
			exclude: []
		)
    ]
)