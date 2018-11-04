//
//  DeleteDocumentTest.swift
//  proNotesUITests
//
//  Created by Timur Khasanov on 10/31/18.
//  Copyright © 2018 leonardthomas. All rights reserved.
//

import XCTest

class DeleteDocumentTest: XCTestCase {
    
    private struct Constants {
        static let amountOfDocumentsAfterDeletion = 0
    }
    
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
    
    func testDeleteDocument() {
        let documentName = prepareDocument()
        
        let appNotesCells = app.collectionViews.cells
        
        deleteDocument(name: documentName)
        XCTAssertTrue(appNotesCells.countVisibleElements == Constants.amountOfDocumentsAfterDeletion)
    }
}
