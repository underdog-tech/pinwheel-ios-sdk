//
//  PinwheelSelectedPlatformEvent.swift
//  PinwheelSDK
//
//  Created by Robby Abaya on 2/11/21.
//

import Foundation

public struct PinwheelSelectedPlatformEvent: Decodable {
    public init(type: String, eventName: String, payload: PinwheelSelectedPlatformPayload) {
        self.type = type
        self.eventName = eventName
        self.payload = payload
    }
    
    public let type: String
    public let eventName: String
    public let payload: PinwheelSelectedPlatformPayload
}
