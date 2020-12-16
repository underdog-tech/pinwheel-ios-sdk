//
//  PinwheelError.swift
//  PinwheelSDK
//
//  Created by Robby Abaya on 11/24/20.
//

import Foundation

public struct PinwheelError: Codable {
    public let errorCode: String
    public let errorMessage: String
}
