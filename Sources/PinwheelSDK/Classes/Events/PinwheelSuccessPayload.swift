//
//  PinwheelSuccessPayload.swift
//  PinwheelSDK
//
//  Created by Robby Abaya on 2/12/21.
//

import Foundation

public struct PinwheelSuccessPayload: Decodable {
    public init(accountId: String, job: String, params: PinwheelParams?, platformId: String) {
        self.accountId = accountId
        self.job = job
        self.params = params
        self.platformId = platformId
    }
    
    public let accountId: String
    public let job: String
    public let params: PinwheelParams?
    public let platformId: String
}
