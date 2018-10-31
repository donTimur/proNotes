//
//  FullScreenTest.swift
//  proNotesUITests
//
//  Created by Timur Khasanov on 10/30/18.
//  Copyright © 2018 leonardthomas. All rights reserved.
//

import XCTest

class FullScreenTest: XCTestCase {

    private var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        app = XCUIApplication()
        app.launch()
        passWelcomeScreen(app: app)
    }
    
    override func tearDown() {
        app = nil
        super.tearDown()
    }

    func testFullScreenDocument() {
        let documentName = createAndOpenDocument(app: app)
        app.buttons[DocumentPage.Constant.fullScreenButton].tap()
        
        XCTAssertFalse(app.tables.staticTexts[DocumentPage.Constant.documentLayers].exists)
        closeDocument(app: app)
        deleteDocument(name: documentName, app: app)
    }
}
