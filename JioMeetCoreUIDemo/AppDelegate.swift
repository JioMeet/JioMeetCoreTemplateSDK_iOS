//
//  AppDelegate.swift
//  JioMeetCoreUIDemo
//
//  Created by Rohit41.Kumar on 06/07/23.
//

import UIKit
import JioMeetUIKit
@main
class AppDelegate: UIResponder, UIApplicationDelegate {



	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
		if #available(iOS 15, *) {
			let appearance = UINavigationBarAppearance()
			appearance.configureWithOpaqueBackground()
			UINavigationBar.appearance().standardAppearance = appearance
			UINavigationBar.appearance().scrollEdgeAppearance = appearance
		}
		
		// Set App group. You can ignore it if you don't want to use screen share feature
		JMUIKit.appGroupName = "group.com.jio.jiomeet.nativesdk"
		
		// Screen Share Extension Bundle Identifier. You can ignore it if you don't want to use screen share feature
		JMUIKit.screenShareExtensionBundleIdentifier = "com.jio.jiomeet.nativesdk.broadcast"
		
		// Enable Participant Panel View. You can ignore it if you don't want to use Participant Panel View
		JMUIKit.isParticipantPanelEnabled = true
		
		// Enable Chat View. You can ignore it if you don't want to use Chat View
		JMUIKit.isChatViewEnabled = true
		
		// Enable Virtual Background Selection View. You can ignore it if you don't want to use Virtual Background
		JMUIKit.isVirtualBackgroundEnabled = true
		
		// Enable White Board Feature. You can ignore it if you don't want to use Whiteboard
		JMUIKit.isWhiteboardEnabled = true
		
		// Enable Start and Stop Recording option. You can ignore if you don't want to handle recording from app side
		JMUIKit.isRecordingEnabled = true
        // Enable Reactions feature. You can ignore it if you don't want to use Reactions
        JMUIKit.isReactionsEnabled = true

		
		// Enable Entry/Exit Chime. You can ignore if you don't want to use this feature
		// Please provide path for Entry/Exit Chime audio files if you enable this feature
		JMUIKit.isEntryExitChimeEnabled = true
		JMUIKit.entryChimeSoundPath = Bundle.main.path(forResource: "user_join_chime", ofType: "mp3") ?? ""
		JMUIKit.exitChimeSoundPath = Bundle.main.path(forResource: "user_left_chime", ofType: "mp3") ?? ""
        
		return true
	}

	// MARK: UISceneSession Lifecycle

	func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
		// Called when a new scene session is being created.
		// Use this method to select a configuration to create the new scene with.
		return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
	}

	func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
		// Called when the user discards a scene session.
		// If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
		// Use this method to release any resources that were specific to the discarded scenes, as they will not return.
	}


}

