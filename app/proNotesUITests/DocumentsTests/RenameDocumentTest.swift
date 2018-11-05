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
        passWelcomeScreen()
    }
    
    override func tearDown() {
        app = nil
        super.tearDown()
    }
    
    func testRenameDocument() {
        let newName = UUID().uuidString
        let elementExistsPredicate = NSPredicate(format: "exists == TRUE")
        let documentName = createAndOpenDocument()
        
        changeFileName( newName: newName)
        closeDocument()
        let element = app.collectionViews.textFields[newName]
        self.expectation(for: elementExistsPredicate, evaluatedWith: element, handler: nil)
        self.waitForExpectations(timeout: 5.0, handler: nil)
        XCTAssertFalse(app.collectionViews.textFields[documentName].exists, "Renamed file has old name expected: \(newName) actual: \(documentName)")
        deleteDocument(name: newName)
    }
    
}
