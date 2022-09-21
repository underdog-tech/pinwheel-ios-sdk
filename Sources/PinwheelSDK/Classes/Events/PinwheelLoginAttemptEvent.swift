//
//  PinwheelLoginAttemptEvent.swift
//  PinwheelSDK
//
//  Created by Robby Abaya on 10/6/21.
//

import Foundation

public struct PinwheelLoginAttemptEvent: Decodable {
    public init(type: String, eventName: String, payload: PinwheelLoginAttemptPayload) {
        self.type = type
        self.eventName = eventName
        self.payload = payload
    }
    
    public let type: String
    public let eventName: String
    public let payload: PinwheelLoginAttemptPayload
}
