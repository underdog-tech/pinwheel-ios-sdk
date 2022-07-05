//
//  PinwheelEventPayload.swift
//  PinwheelSDK
//
//  Created by Robby Abaya on 2/11/21.
//

import Foundation

public protocol PinwheelEventPayload: Codable {
    func jsonString() throws -> String
}

extension PinwheelEventPayload {
    public func jsonString() throws -> String {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let payloadString: String;
        if let jsonData = try? encoder.encode(self), let encoded = String(data: jsonData, encoding: .utf8) {
            payloadString = encoded
        } else {
            payloadString = ""
        }
        return payloadString
    }
}
