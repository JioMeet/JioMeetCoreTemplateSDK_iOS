//
//  SampleHandler.swift
//  ScreenShareExtension
//
//  Created by Rohit41.Kumar on 27/09/23.
//

import ReplayKit
import JioMeetScreenShareSDK

class SampleHandler: JMScreenShareHandler {
    override func getAppGroupsIdentifier() -> String {
        return "group.com.jio.jiomeet.nativesdk"
    }
}
