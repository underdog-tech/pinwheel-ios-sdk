//
//  PinwheelEventPayload.swift
//  PinwheelSDK
//
//  Created by Robby Abaya on 11/24/20.
//

import Foundation

public struct PinwheelEventPayload: Codable {
    public var job: String?
    public var mode: String?
    public var orgName: String?
    public var accountName: String?
    public var accountType: String?
    public var accountNumber: String?
    public var routingNumber: String?
    public var platformKey: String?
    public var employerId: String?
    public var amount: String?
    public var skipIntroScreen: Bool?
    public var skipExitSurvey: Bool?
    public var skipEmployerSearch: Bool?
    public var apiKey: String?
    public var employerSearchText: String?
    public var reason: String?
    public var otherReasonText: String?
    public var foundFromSearch: Bool?
    public var inputtedProvider: String?
    public var searchText: String?
    public var step: String?
    public var href: String?
    public var label: String?
    public var errorCode: String?
    public var errorMsg: String?
    public var pageName: String?
    public var actionName: String?
    public var platformId: String?
    public var selectedEmployerId: String?
    public var selectedEmployerName: String?
    public var modalSessionId: String?
    public var uniqueUserId: String?
}
