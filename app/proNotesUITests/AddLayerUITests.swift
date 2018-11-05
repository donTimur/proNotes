//
//  AddLayerUITests.swift
//  proNotes
//
//  Created by Leo Thomas on 07/07/16.
//  Copyright © 2016 leonardthomas. All rights reserved.
//

import XCTest

class AddLayerUITests: XCTestCase {
        
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
    
    func testCreateTextLayer() {
        let documentName = createAndOpenDocument()
        let layerTableView = app.scrollViews.otherElements.tables
        XCTAssertEqual(layerTableView.cells.matching(identifier: "LayerTableViewCell").count, 0)
        addTextField()
        pressLayerButton()
        XCTAssertTrue(layerTableView.staticTexts["text"].exists, "Textlayer doesn't exists")
        XCTAssertEqual(layerTableView.cells.matching(identifier: "LayerTableViewCell").count, 1)
        closeDocument()
        deleteDocument(name: documentName)
    }
    
    func testCreateImageLayer() {
        let documentName = createAndOpenDocument()
        let layerTableView = app.scrollViews.otherElements.tables
        XCTAssertEqual(layerTableView.cells.matching(identifier: "LayerTableViewCell").count, 0)
        addImage()
        pressLayerButton()
        XCTAssertTrue(layerTableView.staticTexts[DocumentPage.Constant.imageLayer].exists, "Textlayer doesn't exists")
        XCTAssertEqual(layerTableView.cells.matching(identifier: "LayerTableViewCell").count, 1)
        closeDocument()
        deleteDocument(name: documentName)
    }
    
    func testCreateSketchCanvas() {
        let documentName = createAndOpenDocument()
        let layerTableView = app.scrollViews.otherElements.tables
        XCTAssertEqual(layerTableView.cells.matching(identifier: "LayerTableViewCell").count, 0)
        addSketchLayer()
        pressLayerButton()
        XCTAssertTrue(layerTableView.staticTexts["sketch"].exists, "Textlayer doesn't exists")
        XCTAssertEqual(layerTableView.cells.matching(identifier: "LayerTableViewCell").count, 1)
        closeDocument()
        deleteDocument(name: documentName)
    }
    
    func testCreatePage() {
        let documentName = createAndOpenDocument()
        let layerTableView = app.scrollViews.otherElements.tables
        XCTAssertEqual(layerTableView.cells.matching(identifier: "LayerTableViewCell").count, 0)
        let tablesQuery = app.tables.matching(identifier: "PagesOverViewTableView")
        XCTAssertEqual(tablesQuery.cells.count, 1)
        XCTAssertTrue(app.scrollViews.otherElements.staticTexts["Page 1"].exists, "First Page doesnt exist")
        addEmptyPage()
        tablesQuery.cells.containing(.staticText, identifier:"2").children(matching: .button).element.tap()
        XCTAssertTrue(app.scrollViews.otherElements.staticTexts["Page 2"].exists, "Second Page doesnt exist")
        XCTAssertEqual(layerTableView.cells.matching(identifier: "LayerTableViewCell").count, 0)
        XCTAssertEqual(tablesQuery.cells.count, 2)
        closeDocument()
        deleteDocument(name: documentName)
    }
    
}
