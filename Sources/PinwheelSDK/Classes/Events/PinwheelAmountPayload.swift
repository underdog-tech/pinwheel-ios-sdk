//
//  PinwheelAmountPayload.swift
//  PinwheelSDK
//
//  Created by Robby Abaya on 2/12/21.
//

import Foundation

public struct PinwheelAmountPayload: PinwheelEventPayload {
    public var unit: String
    public var value: Float
}
