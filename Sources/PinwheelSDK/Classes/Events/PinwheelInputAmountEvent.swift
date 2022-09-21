//
//  PinwheelInputAmountEvent.swift
//  PinwheelSDK
//
//  Created by Robby Abaya on 2/12/21.
//

import Foundation

public struct PinwheelInputAmountEvent: Decodable {
    public init(type: String, eventName: String, payload: PinwheelAmountPayload) {
        self.type = type
        self.eventName = eventName
        self.payload = payload
    }
    
    public let type: String
    public let eventName: String
    public let payload: PinwheelAmountPayload
}
