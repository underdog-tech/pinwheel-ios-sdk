//
//  PinwheelEvent.swift
//  PinwheelSDK
//
//  Created by Robby Abaya on 2/11/21.
//

import Foundation

public enum PinwheelEventType: String {
    case open
    case selectEmployer = "select_employer"
    case selectPlatform = "select_platform"
    case incorrectPlatformGiven = "incorrect_platform_given"
    case login
    case inputAmount = "input_amount"
    case exit
    case success
    case error
}
