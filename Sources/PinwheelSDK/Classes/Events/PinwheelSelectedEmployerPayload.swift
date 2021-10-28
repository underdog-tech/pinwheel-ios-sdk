//
//  PinwheelSelectedEmployerPayload.swift
//  PinwheelSDK
//
//  Created by Robby Abaya on 2/11/21.
//

import Foundation

public struct PinwheelSelectedEmployerPayload: PinwheelEventPayload {
    public init(selectedEmployerId: String, selectedEmployerName: String) {
        self.selectedEmployerId = selectedEmployerId
        self.selectedEmployerName = selectedEmployerName
    }
    
    public let selectedEmployerId: String
    public let selectedEmployerName: String
}
