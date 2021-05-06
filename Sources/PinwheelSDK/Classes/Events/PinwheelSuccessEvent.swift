//
//  PinwheelSuccessEvent.swift
//  PinwheelSDK
//
//  Created by Robby Abaya on 11/24/20.
//

import Foundation

public struct PinwheelSuccessEvent: Codable {
    public var type: String
    public var eventName: String
    public var payload: PinwheelSuccessPayload
}
