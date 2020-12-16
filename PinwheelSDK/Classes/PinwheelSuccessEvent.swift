//
//  PinwheelSuccessEvent.swift
//  PinwheelSDK
//
//  Created by Robby Abaya on 11/24/20.
//

import Foundation

public struct PinwheelSuccessEvent: Codable {
    public let type: String
    public let result: PinwheelResult
}
