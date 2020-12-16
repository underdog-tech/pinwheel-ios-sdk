//
//  PinwheelActionEvent.swift
//  PinwheelSDK
//
//  Created by Robby Abaya on 11/24/20.
//

import Foundation

public struct PinwheelActionEvent: Codable {
    public var type: String
    public var name: String
    public var payload: PinwheelEventPayload
    public var pageName: String?
    public var actionName: String?
}
