//
//  PinwheelActionEvent.swift
//  PinwheelSDK
//
//  Created by Robby Abaya on 11/24/20.
//

import Foundation

public struct PinwheelActionEvent: Codable {
    var type: String
    var name: String
    var payload: PinwheelEventPayload
    var pageName: String?
    var actionName: String?
}
