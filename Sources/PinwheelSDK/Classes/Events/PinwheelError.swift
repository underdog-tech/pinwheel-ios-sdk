//
//  PinwheelError.swift
//  PinwheelSDK
//
//  Created by Robby Abaya on 11/24/20.
//

import Foundation

public struct PinwheelError: PinwheelEventPayload {
    public init(type: String, code: String, message: String, pendingRetry: Bool) {
        self.type = type
        self.code = code
        self.message = message
        self.pendingRetry = pendingRetry
    }
    
    public let type: String
    public let code: String
    public let message: String
    public let pendingRetry: Bool
}
