//
//  PinwheelInputAmountEvent.swift
//  PinwheelSDK
//
//  Created by Robby Abaya on 2/12/21.
//

import Foundation

public struct PinwheelInputAmountEvent: Codable {
    public init(type: String, eventName: String, payload: PinwheelAmountPayload) {
        self.type = type
        self.eventName = eventName
        self.payload = payload
    }
    
    public var type: String
    public var eventName: String
    public var payload: PinwheelAmountPayload
}
