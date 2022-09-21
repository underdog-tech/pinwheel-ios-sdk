//
//  PinwheelLoginAttemptPayload.swift
//  PinwheelSDK
//
//  Created by Robby Abaya on 10/6/21.
//

import Foundation

public struct PinwheelLoginAttemptPayload: Decodable {
    public init(platformId: String) {
        self.platformId = platformId
    }
    
    public let platformId: String
}
