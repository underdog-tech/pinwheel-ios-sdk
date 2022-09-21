//
//  PinwheelEvent.swift
//  PinwheelSDK
//
//  Created by Robby Abaya on 2/11/21.
//

import Foundation

public enum PinwheelEventType {
    case open
    case selectEmployer(PinwheelSelectedEmployerPayload)
    case selectPlatform(PinwheelSelectedPlatformPayload)
    case incorrectPlatformGiven
    case login(PinwheelLoginPayload)
    case loginAttempt(PinwheelLoginAttemptPayload)
    case inputAmount(PinwheelAmountPayload)
    case inputAllocation(PinwheelInputAllocationPayload)
    case inputRequired
    case exit(PinwheelExitPayload?)
    case success(PinwheelSuccessPayload)
    case error(PinwheelError)
    
    public var name: String {
        switch self {
            
        case .open:
            return "open"
        case .selectEmployer(_):
            return "selectEmployer"
        case .selectPlatform(_):
            return "selectPlatform"
        case .incorrectPlatformGiven:
            return "incorrectPlatformGiven"
        case .login(_):
            return "login"
        case .loginAttempt(_):
            return "loginAttempt"
        case .inputAmount(_):
            return "inputAmount"
        case .inputAllocation(_):
            return "inputAllocation"
        case .inputRequired:
            return "inputRequired"
        case .exit(_):
            return "exit"
        case .success(_):
            return "success"
        case .error(_):
            return "error"
        }
    }
}

enum PinwheelEventName {
    static let open = "open"
    static let selectEmployer = "select_employer"
    static let selectPlatform =  "select_platform"
    static let incorrectPlatformGiven = "incorrect_platform_given"
    static let login = "login"
    static let loginAttempt = "login_attempt"
    static let inputAmount = "input_amount"
    static let inputAllocation = "input_allocation"
    static let inputRequired = "input_required"
    static let exit = "exit"
    static let success = "success"
    static let error = "error"
}
