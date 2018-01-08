//
//  MobilityUITests.swift
//  MobilityUITests
//
//  Created by zeeshan on 03/01/18.
//  Copyright © 2018 zeeshan. All rights reserved.
//

import XCTest

class MobilityUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testEg()
    {
        
        let app = XCUIApplication()
        app/*@START_MENU_TOKEN@*/.textFields["Username"]/*[[".scrollViews.textFields[\"Username\"]",".textFields[\"Username\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let scrollViewsQuery = app.scrollViews
        let textField = scrollViewsQuery.children(matching: .textField).element
        textField.typeText("user")
        
        let moreKey = app/*@START_MENU_TOKEN@*/.keys["more"]/*[[".keyboards",".keys[\"more, numbers\"]",".keys[\"more\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/
        moreKey.tap()
        moreKey.tap()
        textField.typeText("1")
        
        let toolbarDoneButtonButton = app.toolbars.buttons["Toolbar Done Button"]
        toolbarDoneButtonButton.tap()
        app/*@START_MENU_TOKEN@*/.secureTextFields["Password"]/*[[".scrollViews.secureTextFields[\"Password\"]",".secureTextFields[\"Password\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let secureTextField = scrollViewsQuery.children(matching: .secureTextField).element
        secureTextField.typeText("user1")
      
       
        toolbarDoneButtonButton.tap()
        app/*@START_MENU_TOKEN@*/.buttons["Login"]/*[[".scrollViews.buttons[\"Login\"]",".buttons[\"Login\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
    }
    
    func testExample()
    {
        
        
      
    }
    
}
