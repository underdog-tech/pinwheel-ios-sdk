//
//  PinwheelParams.swift
//  PinwheelSDK
//
//  Created by Robby Abaya on 2/12/21.
//

import Foundation

public struct PinwheelParams: Codable {
    public init(amount: PinwheelAmountPayload?) {
        self.amount = amount
    }
    
    public let amount: PinwheelAmountPayload?
}
