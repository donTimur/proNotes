//
//  DocumentSaveFile.swift
//  proNotesUITests
//
//  Created by Timur Khasanov on 11/5/18.
//  Copyright © 2018 leonardthomas. All rights reserved.
//

import XCTest

class DocumentSaveFile: XCTestCase {

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

    func testSaveImage() {
        let documentName = createAndOpenDocument()
        let photoAmountBeforeSave = countPhotosInGallery()
        DocumentPage.screen().buttons["Cancel"].tap()
        saveImage()
        let photoAmountAfterSave = countPhotosInGallery()
        XCTAssertTrue(photoAmountBeforeSave + 1 == photoAmountAfterSave, "Photo was not saved and didnot appear in gallery")
    }

}
