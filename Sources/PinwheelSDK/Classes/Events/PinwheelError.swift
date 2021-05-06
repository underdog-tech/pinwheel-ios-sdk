//
//  PinwheelError.swift
//  PinwheelSDK
//
//  Created by Robby Abaya on 11/24/20.
//

import Foundation

public struct PinwheelError: PinwheelEventPayload {
    public let type: String
    public let code: String
    public let message: String
    public let pendingRetry: Bool
}
