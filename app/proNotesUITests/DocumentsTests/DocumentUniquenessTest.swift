//
//  DocumentUniquenessTest.swift
//  proNotesUITests
//
//  Created by Timur Khasanov on 10/27/18.
//  Copyright © 2018 leonardthomas. All rights reserved.
//

import XCTest

class DocumentUniquenessTest: XCTestCase {
    
    private var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        app = XCUIApplication()
        app.launch()
        passWelcomeScreen()
    }
    
    override func tearDown() {
        app = nil
        super.tearDown()
    }
    func testForDuplicates() {
        let documentName = prepareDocument()
        let newDocumentName = prepareDocument()
        app.collectionViews.cells.staticTexts[documentName].waitForExistence(timeout: 3)
        XCTAssertTrue(newDocumentName != documentName, "New document was created with a non-unique name")
        deleteDocument(name: documentName)
        deleteDocument(name: newDocumentName)
    }
    
}
