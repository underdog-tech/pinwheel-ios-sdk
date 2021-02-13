//
//  PinwheelInputAmountEvent.swift
//  PinwheelSDK
//
//  Created by Robby Abaya on 2/12/21.
//

import Foundation

public struct PinwheelInputAmountEvent: Codable {
    public var type: String
    public var eventName: String
    public var payload: PinwheelInputAmountPayload
}
