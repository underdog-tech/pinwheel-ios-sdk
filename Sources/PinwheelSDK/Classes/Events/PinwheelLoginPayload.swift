//
//  PinwheelLoginPayload.swift
//  PinwheelSDK
//
//  Created by Robby Abaya on 2/11/21.
//

import Foundation

public struct PinwheelLoginPayload: Decodable {
    public init(accountId: String, platformId: String) {
        self.accountId = accountId
        self.platformId = platformId
    }
    
    public let accountId: String
    public let platformId: String
}
