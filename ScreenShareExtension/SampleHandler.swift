//
//  SampleHandler.swift
//  ScreenShareExtension
//
//  Created by Rohit41.Kumar on 27/09/23.
//

import ReplayKit
import JioMeetScreenShareSDK

class SampleHandler: JMScreenShareHandler {
	
	let appGroupsIdentifier: String = "group.com.jio.jiomeet.nativesdk"
	
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
