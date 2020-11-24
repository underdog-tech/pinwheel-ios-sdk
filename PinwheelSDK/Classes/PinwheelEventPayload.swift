//
//  PinwheelEventPayload.swift
//  PinwheelSDK
//
//  Created by Robby Abaya on 11/24/20.
//

import Foundation

public struct PinwheelEventPayload: Codable {
    var job: String?
    var mode: String?
    var orgName: String?
    var accountName: String?
    var accountType: String?
    var accountNumber: String?
    var routingNumber: String?
    var platformKey: String?
    var employerId: String?
    var amount: String?
    var skipIntroScreen: Bool?
    var skipExitSurvey: Bool?
    var skipEmployerSearch: Bool?
    var apiKey: String?
    var employerSearchText: String?
    var reason: String?
    var otherReasonText: String?
    var foundFromSearch: Bool?
    var inputtedProvider: String?
    var searchText: String?
    var step: String?
    var href: String?
    var label: String?
    var errorCode: String?
    var errorMsg: String?
    var pageName: String?
    var actionName: String?
    var platformId: String?
    var selectedEmployerId: String?
    var selectedEmployerName: String?
    var modalSessionId: String?
    var uniqueUserId: String?
}
