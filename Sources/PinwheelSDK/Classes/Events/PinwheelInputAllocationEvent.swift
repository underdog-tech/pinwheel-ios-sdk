//
//  PinwheelInputAllocationEvent.swift
//  PinwheelSDK
//
//  Created by Robby Abaya on 7/11/22.
//

import Foundation

public struct PinwheelInputAllocationEvent: Codable {
    public init(type: String, eventName: String, payload: PinwheelInputAllocationPayload) {
        self.type = type
        self.eventName = eventName
        self.payload = payload
    }
    
    public var type: String
    public var eventName: String
    public var payload: PinwheelInputAllocationPayload
}
