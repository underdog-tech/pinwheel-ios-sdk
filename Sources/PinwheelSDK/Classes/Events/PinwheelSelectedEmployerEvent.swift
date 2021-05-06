//
//  PinwheelSelectedEmployerEvent.swift
//  PinwheelSDK
//
//  Created by Robby Abaya on 2/11/21.
//

import Foundation

public struct PinwheelSelectedEmployerEvent: Codable {
    public var type: String
    public var eventName: String
    public var payload: PinwheelSelectedEmployerPayload
}
