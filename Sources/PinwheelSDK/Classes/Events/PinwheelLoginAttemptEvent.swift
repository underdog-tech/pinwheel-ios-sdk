//
//  PinwheelLoginAttemptEvent.swift
//  PinwheelSDK
//
//  Created by Robby Abaya on 10/6/21.
//

import Foundation

public struct PinwheelLoginAttemptEvent: Codable {
    public init(type: String, eventName: String, payload: PinwheelLoginAttemptPayload) {
        self.type = type
        self.eventName = eventName
        self.payload = payload
    }
    
    public var type: String
    public var eventName: String
    public var payload: PinwheelLoginAttemptPayload
}
