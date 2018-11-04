//
//  LayerTableViewUITests.swift
//  proNotes
//
//  Created by Leo Thomas on 07/07/16.
//  Copyright © 2016 leonardthomas. All rights reserved.
//

import XCTest

class LayerTableViewUITests: XCTestCase {
        
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
    
    func testDeleteLayer() {
        let documentName = createAndOpenDocument()
        addTextField(app: app)
        pressLayerButton(app: app)

        let layerTableView = app.scrollViews.otherElements.tables
        let textFieldCell = layerTableView.cells.matching(identifier: "LayerTableViewCell").element(boundBy: 0)
        textFieldCell.buttons.matching(identifier: "deleteLayerButton").element.tap()
        XCTAssertEqual(layerTableView.cells.matching(identifier: "LayerTableViewCell").count, 0)
        closeDocument()
        deleteDocument(name: documentName)
    }
}
