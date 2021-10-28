//
//  PinwheelLoginEvent.swift
//  PinwheelSDK
//
//  Created by Robby Abaya on 2/11/21.
//

import Foundation

public struct PinwheelLoginEvent: Codable {
    public init(type: String, eventName: String, payload: PinwheelLoginPayload) {
        self.type = type
        self.eventName = eventName
        self.payload = payload
    }
    
    public var type: String
    public var eventName: String
    public var payload: PinwheelLoginPayload
}
