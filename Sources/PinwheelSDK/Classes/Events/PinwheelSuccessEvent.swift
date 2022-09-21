//
//  PinwheelSuccessEvent.swift
//  PinwheelSDK
//
//  Created by Robby Abaya on 11/24/20.
//

import Foundation

public struct PinwheelSuccessEvent: Decodable {
    public init(type: String, eventName: String, payload: PinwheelSuccessPayload) {
        self.type = type
        self.eventName = eventName
        self.payload = payload
    }
    
    public let type: String
    public let eventName: String
    public let payload: PinwheelSuccessPayload
}
