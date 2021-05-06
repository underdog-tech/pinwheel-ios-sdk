//
//  PinwheelSelectedPlatformPayload.swift
//  PinwheelSDK
//
//  Created by Robby Abaya on 2/11/21.
//

import Foundation

public struct PinwheelSelectedPlatformPayload: PinwheelEventPayload {
    public let selectedPlatformId: String
    public let selectedPlatformName: String
}
