//
//  DrawOnDocumentTest.swift
//  proNotesUITests
//
//  Created by Timur Khasanov on 10/31/18.
//  Copyright © 2018 leonardthomas. All rights reserved.
//

import XCTest

class SliderTest: XCTestCase {
    
    private struct Constant {
        static let position = CGFloat(1.0)
        static let sliderMaxPosition = "100%"
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
    
    func testSliderMaxPosition() {
        let documentName = createAndOpenDocument(app: app)
        
        app.buttons[DocumentPage.Constant.pen].tap()
        
        let slider = app.sliders[DocumentPage.Constant.drawSlider]
        let sliderToString = moveSlider(slider: slider, position: Constant.position)
        XCTAssertTrue(sliderToString == Constant.sliderMaxPosition)
        deleteDocument(name: documentName, app: app)
    }
}
