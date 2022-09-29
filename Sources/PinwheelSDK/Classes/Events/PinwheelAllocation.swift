//
//  PinwheelAllocation.swift
//  PinwheelSDK
//
//  Created by Robby Abaya on 7/11/22.
//

import Foundation

public struct PinwheelAllocation: Codable {
    public let type: String
    public let value: Float?
    public let target: PinwheelTarget?
}
