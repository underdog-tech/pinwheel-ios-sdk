//
//  PinwheelLoginEvent.swift
//  PinwheelSDK
//
//  Created by Robby Abaya on 2/11/21.
//

import Foundation

public struct PinwheelLoginEvent: Decodable {
    public init(type: String, eventName: String, payload: PinwheelLoginPayload) {
        self.type = type
        self.eventName = eventName
        self.payload = payload
    }
    
    public let type: String
    public let eventName: String
    public let payload: PinwheelLoginPayload
}
