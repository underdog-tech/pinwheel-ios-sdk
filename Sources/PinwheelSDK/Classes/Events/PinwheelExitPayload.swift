//
//  PinwheelExitPayload.swift
//  PinwheelSDK
//
//  Created by Robby Abaya on 2/15/21.
//

import Foundation

public struct PinwheelExitPayload: PinwheelEventPayload {
    public init(error: PinwheelError?) {
        self.error = error
    }
    
    public let error: PinwheelError?
}
