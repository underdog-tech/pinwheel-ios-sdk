//
//  PinwheelExitEvent.swift
//  PinwheelSDK
//
//  Created by Robby Abaya on 11/24/20.
//

import Foundation

public struct PinwheelExitEvent: Codable {
    let type: String
    let error: PinwheelError?
    let result: PinwheelResult?
}
