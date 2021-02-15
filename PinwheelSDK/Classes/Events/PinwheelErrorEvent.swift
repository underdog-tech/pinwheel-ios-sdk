//
//  PinwheelErrorEvent.swift
//  PinwheelSDK
//
//  Created by Robby Abaya on 2/12/21.
//

import Foundation

public struct PinwheelErrorEvent: Codable {
    public let type: String
    public let eventName: String
    public let payload: PinwheelError
}
