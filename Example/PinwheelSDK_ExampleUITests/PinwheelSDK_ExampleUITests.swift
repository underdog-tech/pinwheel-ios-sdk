//
//  PinwheelSDK_ExampleUITests.swift
//  PinwheelSDK_ExampleUITests
//
//  Created by Robby Abaya on 8/2/21.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import XCTest

class PinwheelSDK_ExampleUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExit() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["Fetch Link Token"]/*[[".cells",".buttons[\"Fetch Link Token\"].staticTexts[\"Fetch Link Token\"]",".staticTexts[\"Fetch Link Token\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let webViewsQuery = app.webViews.webViews.webViews
        webViewsQuery.buttons["Close Button"].tap()
        webViewsQuery.buttons["Exit Confirmation Button"].tap()
        
        
        let myTable = app.tables["eventsTableView"]
        XCTAssertEqual(myTable.cells["open_0"].staticTexts["open"].label, "open")
        XCTAssertEqual(myTable.cells["exit_1"].staticTexts["exit"].label, "exit")
    }
}
