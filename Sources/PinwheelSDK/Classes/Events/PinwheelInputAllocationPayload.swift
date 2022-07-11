//
//  PinwheelInputAllocationPayload.swift
//  PinwheelSDK
//
//  Created by Robby Abaya on 7/11/22.
//

import Foundation

public struct PinwheelInputAllocationPayload: PinwheelEventPayload {
    public let action: String
    public let allocation: PinwheelAllocation?
}
