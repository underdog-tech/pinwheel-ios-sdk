//
//  PinwheelScreenTransitionPayload.swift
//  PinwheelSDK
//
//  Created by Elena Churilova on 5/4/23.
//

import Foundation

public struct PinwheelScreenTransitionPayload: PinwheelEventPayload {
    public init(selectedPlatformId: String, selectedPlatformName: String) {
        self.screenName = screenName
        self.selectedEmployerId = selectedEmployerId
        self.selectedEmployerName = selectedEmployerName
        self.selectedPlatformId = selectedPlatformId
        self.selectedPlatformName = selectedPlatformName
    }
    
    public let screenName: String
    public let selectedEmployerId: String?
    public let selectedEmployerName: String?
    public let selectedPlatformId: String?
    public let selectedPlatformName: String?


}
