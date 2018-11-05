//
//  DocumentDrawTest.swift
//  proNotesUITests
//
//  Created by Timur Khasanov on 11/4/18.
//  Copyright © 2018 leonardthomas. All rights reserved.
//

import XCTest
import FBSnapshotTestCase
import UIKit

class DocumentDrawTest: FBSnapshotTestCase {

    private var app: XCUIApplication!
    private struct Constant {
        static let position = CGFloat(1.0)
        static let sliderMaxPosition = "100%"
    }
    override func setUp() {
        super.setUp()
        app = XCUIApplication()
        app.launch()
        passWelcomeScreen()
        self.recordMode = false
    }

    override func tearDown() {
        app = nil
        super.tearDown()
    }
    
    func verifyView(file: StaticString = #file, line: UInt = #line) {
        guard let croppedImage = app.screenshot().image.removingStatusBar else {
            return XCTFail("An error occurred while cropping the screenshot", file: file, line: line)
        }
        
        FBSnapshotVerifyView(UIImageView(image: croppedImage), tolerance: 0.01)
        
    }

    func testDocumentDraw() {
        let documentName = createAndOpenDocument()
        documentDrawingModeOn()
        XCTAssertTrue(colorPallete().exists, "ColorView element is not visible")
        moveSlider(position: Constant.position)
        chooseBlueColor()

        enterFullScreen()
        app.pressAndDragTo(.V)
        app.pressAndDragTo(.K)
        verifyView()
        closeDocument()
        deleteDocument(name: documentName)
    }

}
