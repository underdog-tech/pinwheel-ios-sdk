//
//  PinwheelSuccessPayload.swift
//  PinwheelSDK
//
//  Created by Robby Abaya on 2/12/21.
//

import Foundation

public struct PinwheelSuccessPayload: PinwheelEventPayload {
    public init(accountId: String, job: String, params: PinwheelParams?) {
        self.accountId = accountId
        self.job = job
        self.params = params
    }
    
    public let accountId: String
    public let job: String
    public let params: PinwheelParams?
}
