//
//  PinwheelAmountPayload.swift
//  PinwheelSDK
//
//  Created by Robby Abaya on 2/12/21.
//

import Foundation

public struct PinwheelAmountPayload: Decodable {
    public init(unit: String, value: Float) {
        self.unit = unit
        self.value = value
    }
    
    public let unit: String
    public let value: Float
}
