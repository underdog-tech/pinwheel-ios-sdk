//
//  PinwheelExitEvent.swift
//  PinwheelSDK
//
//  Created by Robby Abaya on 11/24/20.
//

import Foundation

public struct PinwheelExitEvent: Codable {
    public let type: String
    public let eventName: String
    public let error: PinwheelError?
}
