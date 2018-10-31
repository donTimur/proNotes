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
        passWelcomeScreen(app: app)
    }
    
    override func tearDown() {
        app = nil
        super.tearDown()
    }

    func testCancelRename() {
        let documentName = createAndOpenDocument(app: app)
        
        let textField = changeFileName(app: app, newName: documentName)
        app.alerts.buttons[DocumentPage.Constant.cancelButton].tap()
        XCTAssertEqual(textField.value as? String, documentName)
        closeDocument(app: app)
        deleteDocument(name: documentName, app: app)
    }
    
    func testRenameDocument() {
        let randomName = UUID().uuidString
        createAndOpenDocument(app: app)
        
        let textField = changeFileName(app: app, newName: randomName)
        
        XCTAssertEqual(randomName, textField.value as? String)
        closeDocument(app: app)
        deleteDocument(name: randomName, app: app)
    }
    
    func testRenameOverrideDocument() {
        let documentNameFirst = prepareDocument(app: app)
        let documentNameSecond = createAndOpenDocument(app: app)
        
        let textField = changeFileName(app: app, newName: documentNameFirst)
    
        app.buttons[DocumentPage.Constant.overrideButton].tap()
        
        XCTAssertEqual(documentNameFirst, textField.value as? String)
        
        closeDocument(app: app)
        
        XCTAssertTrue(app.collectionViews.cells.countVisibleElements == Constants.amountOfdocumentsAfterOverriding)
        XCTAssertTrue(app.collectionViews.textFields[documentNameFirst].exists)
        deleteDocument(name: documentNameFirst, app: app)
        deleteDocument(name: documentNameSecond, app: app)
    }
    
    func testErrorOnTheSameNameRenaming() {
        let documentName = createAndOpenDocument(app: app)
        let textField = changeFileName(app: app, newName: documentName)
        app.buttons[DocumentPage.Constant.overrideButton].tap()
        
        XCTAssertTrue(app.staticTexts["An Error occured. Please try again"].exists)
        app.buttons["Ok"].tap()
        
        XCTAssertEqual(documentName, textField.value as? String)
        closeDocument(app: app)
        deleteDocument(name: documentName, app: app)
    }

}
