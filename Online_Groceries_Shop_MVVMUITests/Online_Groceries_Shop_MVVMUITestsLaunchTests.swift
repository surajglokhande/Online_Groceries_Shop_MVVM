//
//  Online_Groceries_Shop_MVVMUITestsLaunchTests.swift
//  Online_Groceries_Shop_MVVMUITests
//
//  Created by Suraj Lokhande2 on 20/03/25.
//

import XCTest

final class Online_Groceries_Shop_MVVMUITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    @MainActor
    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()

        // Insert steps here to perform after app launch but before taking a screenshot,
        // such as logging into a test account or navigating somewhere in the app

        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
