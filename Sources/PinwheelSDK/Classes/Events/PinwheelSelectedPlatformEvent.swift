//
//  PinwheelSelectedPlatformEvent.swift
//  PinwheelSDK
//
//  Created by Robby Abaya on 2/11/21.
//

import Foundation

public struct PinwheelSelectedPlatformEvent: Codable {
    public init(type: String, eventName: String, payload: PinwheelSelectedPlatformPayload) {
        self.type = type
        self.eventName = eventName
        self.payload = payload
    }
    
    public var type: String
    public var eventName: String
    public var payload: PinwheelSelectedPlatformPayload
}
