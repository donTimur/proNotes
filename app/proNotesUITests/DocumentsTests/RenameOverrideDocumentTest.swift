//
//  RenameOverrideDocumentTest.swift
//  proNotesUITests
//
//  Created by Timur Khasanov on 10/30/18.
//  Copyright © 2018 leonardthomas. All rights reserved.
//

import XCTest

class RenameOverrideDocumentTest: XCTestCase {
    
    private struct Constants {
        static let amountOfdocumentsAfterOverriding = 1
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
    
    func testCancelRename() {
        let documentName = createAndOpenDocument()
        
        let textField = changeFileName(app: app, newName: documentName)
        app.alerts.buttons[DocumentPage.Constant.cancelButton].tap()
        XCTAssertEqual(textField.value as? String, documentName)
        closeDocument()
        deleteDocument(name: documentName)
    }
    
    func testRenameDocument() {
        let randomName = UUID().uuidString
        createAndOpenDocument()
        
        let textField = changeFileName(app: app, newName: randomName)
        
        XCTAssertEqual(randomName, textField.value as? String)
        closeDocument()
        deleteDocument(name: randomName)
    }
    
    func testRenameOverrideDocument() {
        let documentNameFirst = prepareDocument()
        let documentNameSecond = createAndOpenDocument()
        
        let textField = changeFileName(app: app, newName: documentNameFirst)
        
        app.buttons[DocumentPage.Constant.overrideButton].tap()
        
        XCTAssertEqual(documentNameFirst, textField.value as? String)
        
        closeDocument()
        
        XCTAssertTrue(app.collectionViews.cells.countVisibleElements == Constants.amountOfdocumentsAfterOverriding)
        XCTAssertTrue(app.collectionViews.textFields[documentNameFirst].exists)
        deleteDocument(name: documentNameFirst)
        deleteDocument(name: documentNameSecond)
    }
    
    func testErrorOnTheSameNameRenaming() {
        let documentName = createAndOpenDocument()
        let textField = changeFileName(app: app, newName: documentName)
        app.buttons[DocumentPage.Constant.overrideButton].tap()
        
        XCTAssertTrue(app.staticTexts["An Error occured. Please try again"].exists)
        app.buttons["Ok"].tap()
        
        XCTAssertEqual(documentName, textField.value as? String)
        closeDocument()
        deleteDocument(name: documentName)
    }
    
}
