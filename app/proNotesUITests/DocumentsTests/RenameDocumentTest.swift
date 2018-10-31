//
//  RenameDocumentTest.swift
//  proNotesUITests
//
//  Created by Timur Khasanov on 10/27/18.
//  Copyright © 2018 leonardthomas. All rights reserved.
//

import XCTest

class RenameDocumentTest: XCTestCase {

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

func testRenameDocument() {
        let newName = UUID().uuidString
        
        let documentName = createAndOpenDocument(app: app)
        
        changeFileName(app: app, newName: newName)
        closeDocument(app: app)
        XCTAssertFalse(app.collectionViews.textFields[documentName].exists)
        deleteDocument(name: newName, app: app)
    }

}
