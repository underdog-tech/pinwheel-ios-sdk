//
//  PinwheelScreenTransitionEvent.swift
//  PinwheelSDK
//
//  Created by Elena Churilova on 5/4/23.
//

import Foundation

public struct PinwheelScreenTransitionEvent: Codable {
    public init(type: String, eventName: String, payload: PinwheelScreenTransitionPayload) {
        self.type = type
        self.eventName = eventName
        self.payload = payload
    }
    
    public var type: String
    public var eventName: String
    public var payload: PinwheelScreenTransitionPayload
}
