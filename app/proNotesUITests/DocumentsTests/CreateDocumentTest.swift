//
//  CreateDocumentTest.swift
//  proNotesUITests
//
//  Created by Timur Khasanov on 10/28/18.
//  Copyright © 2018 leonardthomas. All rights reserved.
//

import XCTest

class CreateDocumentTest: XCTestCase {
    
    //private var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        XCUIApplication().launch()
        passWelcomeScreen()
    }
    
    override func tearDown() {
        //app = nil
        super.tearDown()
    }
    
    func testCreateDocument() {
        let amountOfDocuments = DocumentPage.cell().countVisibleElements
        let documentName = prepareDocument()
        
        XCTAssertTrue(amountOfDocuments + 1 == DocumentPage.cell().countVisibleElements,
                      "Amount of documents after creation expected: \(amountOfDocuments + 1), but showed: \(DocumentPage.cell().countVisibleElements)")
        
        XCTAssertTrue(DocumentPage.cell().textFields[documentName].exists, "Document with name \(documentName) hasnot been created")
        deleteDocument(name: documentName)
        XCTAssertTrue(DocumentPage.cell().countVisibleElements == amountOfDocuments,
                      "Amount of documents after deletion expected: \(amountOfDocuments), but showed: \(DocumentPage.cell().countVisibleElements)")
    }
    
    func testDateOfCreateDocument() {
        let date = getCurrentDate()
        let documentName = prepareDocument()
        
        let appNotesCells = DocumentPage.cell().staticTexts[date]
        
        XCTAssertTrue(appNotesCells.exists, "Document created with wrong date expected: \(date) but actual is \(appNotesCells.value)")
        deleteDocument(name: documentName)
    }
}
