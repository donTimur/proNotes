//
//  RenameOverrideDocumentTest.swift
//  proNotesUITests
//
//  Created by Timur Khasanov on 10/30/18.
//  Copyright © 2018 leonardthomas. All rights reserved.
//

import XCTest

class RenameOverrideDocumentTest: XCTestCase {
    
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
    
    func testCancelRename() {
        let documentName = createAndOpenDocument()
        
        let textField = changeFileName( newName: documentName)
        app.alerts.buttons[DocumentPage.Constant.cancelButton].tap()
        XCTAssertEqual(textField.value as? String, documentName, "Cancellation of rename didnt work expected: \(documentName) actual: \(textField.value)")
        closeDocument()
        deleteDocument(name: documentName)
    }
    
    func testRenameDocument() {
        let randomName = UUID().uuidString
        createAndOpenDocument()
        
        let textField = changeFileName(newName: randomName)
        
        XCTAssertEqual(randomName, textField.value as? String, "Document rename didnt work out expected: \(randomName) actual: \(textField.value)")
        closeDocument()
        deleteDocument(name: randomName)
    }
    
    func testRenameOverrideDocument() {
        let amountOfDocuments = DocumentPage.cell().countVisibleElements
        let documentNameFirst = prepareDocument()
        let documentNameSecond = createAndOpenDocument()
        
        let textField = changeFileName(newName: documentNameFirst)
        
        app.buttons[DocumentPage.Constant.overrideButton].tap()
        
        XCTAssertEqual(documentNameFirst, textField.value as? String)
        
        closeDocument()
        
        XCTAssertTrue(amountOfDocuments + 1 == DocumentPage.cell().countVisibleElements)
        XCTAssertTrue(app.collectionViews.textFields[documentNameFirst].exists)
        deleteDocument(name: documentNameFirst)
    }
    
    func testErrorOnTheSameNameRenaming() {
        let documentName = createAndOpenDocument()
        let textField = changeFileName(newName: documentName)
        app.buttons[DocumentPage.Constant.overrideButton].tap()
        
        XCTAssertTrue(app.staticTexts["An Error occured. Please try again"].exists, "Error on the same name renaming didnt appear")
        app.buttons["Ok"].tap()
        
        XCTAssertEqual(documentName, textField.value as? String)
        closeDocument()
        deleteDocument(name: documentName)
    }
    
}
