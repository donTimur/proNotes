//
//  DocumentUniquenessTest.swift
//  proNotesUITests
//
//  Created by Timur Khasanov on 10/27/18.
//  Copyright © 2018 leonardthomas. All rights reserved.
//

import XCTest

class DocumentUniquenessTest: XCTestCase {

    var implicitWait: Int = 3
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

    func testForDuplicates() {
        let documentName = prepareDocument(app: app)
        let newDocumentName = prepareDocument(app: app)
        app.collectionViews.cells.staticTexts[documentName].waitForExistence(timeout: implicitWait)
        XCTAssertTrue(newDocumentName != documentName)
        deleteDocument(name: documentName, app: app)
        deleteDocument(name: newDocumentName, app: app)
    }

}
