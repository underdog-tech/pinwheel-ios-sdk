//
//  PinwheelSuccessEvent.swift
//  PinwheelSDK
//
//  Created by Robby Abaya on 11/24/20.
//

import Foundation

public struct PinwheelSuccessEvent: Codable {
    let type: String
    let result: PinwheelResult
}
