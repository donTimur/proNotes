//
//  CreateDocumentTest.swift
//  proNotesUITests
//
//  Created by Timur Khasanov on 10/28/18.
//  Copyright © 2018 leonardthomas. All rights reserved.
//

import XCTest

class CreateDocumentTest: XCTestCase {
    
    private struct Constants {
        static let amountOfdocumentsAfterCreating = 1
        static let amountOfDocumentsAfterDeletion = 0
    }
    
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

    func testCreateDocument() {
        let documentName = prepareDocument(app: app)
        
        let appNotesCells = app.collectionViews.cells
        
        XCTAssertTrue(appNotesCells.countVisibleElements == Constants.amountOfdocumentsAfterCreating)
        XCTAssertTrue(appNotesCells.textFields[documentName].exists)
        deleteDocument(name: documentName, app: app)
        XCTAssertTrue(appNotesCells.countVisibleElements == Constants.amountOfDocumentsAfterDeletion)
    }
    
    func testDateOfCreateDocument() {
        let date = getCurrentDate()
        let documentName = prepareDocument(app: app)
        
        let appNotesCells = app.collectionViews.cells
        
        XCTAssertTrue(appNotesCells.staticTexts[date].exists)
        deleteDocument(name: documentName, app: app)
    }
}
