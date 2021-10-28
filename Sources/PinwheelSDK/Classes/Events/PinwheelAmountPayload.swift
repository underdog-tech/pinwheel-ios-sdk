//
//  PinwheelAmountPayload.swift
//  PinwheelSDK
//
//  Created by Robby Abaya on 2/12/21.
//

import Foundation

public struct PinwheelAmountPayload: PinwheelEventPayload {
    public init(unit: String, value: Float) {
        self.unit = unit
        self.value = value
    }
    
    public var unit: String
    public var value: Float
}
