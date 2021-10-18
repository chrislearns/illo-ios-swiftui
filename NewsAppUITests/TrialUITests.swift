//
//  TrialUITests.swift
//  NewsAppUITests
//
//  Created by Chris Guirguis on 10/15/21.
//

import Foundation
import XCTest

class TrialUITests: XCTestCase {
    let app = XCUIApplication()
    
    func testLaunchAndTerminate() throws {
        app.launch()
        print("APP LAUNCHED")
        app.terminate()
        print("APP TERMINATED")
    }
    
    func testNavigatingProperly() throws {
        app.launch()
        let tabBar = XCUIApplication().tabBars["Tab Bar"]
        
        tabBar.buttons["My News"].tap()
        sleep(UInt32(0.5))
        tabBar.buttons["Topics"].tap()
        sleep(UInt32(0.5))
        tabBar.buttons["More"].tap()
        sleep(UInt32(0.5))
        tabBar.buttons["Home"].tap()
        sleep(UInt32(0.5))
                        
    }
}
