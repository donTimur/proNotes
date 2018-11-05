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
        passWelcomeScreen()
    }
    
    override func tearDown() {
        app = nil
        super.tearDown()
    }
    
    func testSliderMaxPosition() {
        let documentName = createAndOpenDocument()
        
        documentDrawingModeOn()
        let sliderToString = moveSlider(position: Constant.position)
        XCTAssertTrue(sliderToString == Constant.sliderMaxPosition, "Slider is not on max position")
        closeDocument()
        deleteDocument(name: documentName)
    }
}
