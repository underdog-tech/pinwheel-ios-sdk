//
//  PinwheelLoginAttemptEvent.swift
//  PinwheelSDK
//
//  Created by Robby Abaya on 10/6/21.
//

import Foundation

public struct PinwheelLoginAttemptEvent: Codable {
    public var type: String
    public var eventName: String
    public var payload: PinwheelLoginAttemptPayload
}
