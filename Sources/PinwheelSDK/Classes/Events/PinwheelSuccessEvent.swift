//
//  PinwheelSuccessEvent.swift
//  PinwheelSDK
//
//  Created by Robby Abaya on 11/24/20.
//

import Foundation

public struct PinwheelSuccessEvent: Codable {
    public init(type: String, eventName: String, payload: PinwheelSuccessPayload) {
        self.type = type
        self.eventName = eventName
        self.payload = payload
    }
    
    public var type: String
    public var eventName: String
    public var payload: PinwheelSuccessPayload
}
