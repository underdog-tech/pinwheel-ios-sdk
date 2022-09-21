//
//  PinwheelInputAllocationEvent.swift
//  PinwheelSDK
//
//  Created by Robby Abaya on 7/11/22.
//

import Foundation

public struct PinwheelInputAllocationEvent: Decodable {
    public init(type: String, eventName: String, payload: PinwheelInputAllocationPayload) {
        self.type = type
        self.eventName = eventName
        self.payload = payload
    }
    
    public let type: String
    public let eventName: String
    public let payload: PinwheelInputAllocationPayload
}
