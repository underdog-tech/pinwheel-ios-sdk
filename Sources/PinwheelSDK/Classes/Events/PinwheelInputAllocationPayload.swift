//
//  PinwheelInputAllocationPayload.swift
//  PinwheelSDK
//
//  Created by Robby Abaya on 7/11/22.
//

import Foundation

public struct PinwheelInputAllocationPayload: Decodable {
    init(action: String, allocation: PinwheelAllocation?) {
        self.action = action
        self.allocation = allocation
    }
    public let action: String
    public let allocation: PinwheelAllocation?
}
