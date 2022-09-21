//
//  PinwheelSelectedPlatformPayload.swift
//  PinwheelSDK
//
//  Created by Robby Abaya on 2/11/21.
//

import Foundation

public struct PinwheelSelectedPlatformPayload: Decodable {
    public init(selectedPlatformId: String, selectedPlatformName: String) {
        self.selectedPlatformId = selectedPlatformId
        self.selectedPlatformName = selectedPlatformName
    }
    
    public let selectedPlatformId: String
    public let selectedPlatformName: String
}
