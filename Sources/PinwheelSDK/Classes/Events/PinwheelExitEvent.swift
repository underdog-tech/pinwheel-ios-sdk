//
//  PinwheelExitEvent.swift
//  PinwheelSDK
//
//  Created by Robby Abaya on 11/24/20.
//

import Foundation

public struct PinwheelExitEvent: Codable {
    public init(type: String, eventName: String, payload: PinwheelExitPayload?) {
        self.type = type
        self.eventName = eventName
        self.payload = payload
    }
    
    public let type: String
    public let eventName: String
    public let payload: PinwheelExitPayload?
}
