//
//  DocumentDrawTest.swift
//  proNotesUITests
//
//  Created by Timur Khasanov on 11/4/18.
//  Copyright © 2018 leonardthomas. All rights reserved.
//

import XCTest
import FBSnapshotTestCase

class DocumentDrawTest: FBSnapshotTestCase {

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
    }

    override func tearDown() {
        app = nil
        super.tearDown()
    }

    func testDocumentDraw() {
        let documentName = createAndOpenDocument()
        documentDrawingModeOn()
        let colorView = app.scrollViews.otherElements.collectionViews["colorView"]
        colorView.children(matching: .cell).element(boundBy: 2)
        XCTAssertTrue(colorView.exists)
        moveSlider(position: Constant.position)
        chooseBlueColor()

        enterFullScreen()
        app.pressAndDragTo(.V)
        app.pressAndDragTo(.K)
        
        closeDocument()
        deleteDocument(name: documentName)
    }

}

extension XCUIElement
{
    enum letters : Int {
        case V, K
    }
    
    func pressAndDragTo(_ letter : letters) {
        let start: CGFloat = 0.15
        let step : CGFloat = 0.2
        let pressDuration : TimeInterval = 0.1
        
        let startV = start + step
        
        let KDown = startV + step + 0.05
        
        let letterV = self.coordinate(withNormalizedOffset: CGVector(dx: start, dy: start))
        let letterMiddleV = self.coordinate(withNormalizedOffset: CGVector(dx: startV, dy: startV))
        let letterEndV = self.coordinate(withNormalizedOffset: CGVector(dx: startV + step, dy: start))
        
        let startK = self.coordinate(withNormalizedOffset: CGVector(dx: KDown, dy: start))
        let letterKDown = self.coordinate(withNormalizedOffset: CGVector(dx: KDown, dy: startV))
        let letterKMiddle = self.coordinate(withNormalizedOffset: CGVector(dx: KDown, dy: startV - 0.1))
        let letterKUp = self.coordinate(withNormalizedOffset: CGVector(dx: KDown+step, dy: start))
        let letterKCross = self.coordinate(withNormalizedOffset: CGVector(dx: KDown+step, dy: start+adjustment))
        
        switch letter {
        case .V:
            letterV.press(forDuration: pressDuration, thenDragTo: letterMiddleV)
            letterMiddleV.press(forDuration: pressDuration, thenDragTo: letterEndV)
            break
        case .K:
            startK.press(forDuration: pressDuration, thenDragTo: letterKDown)
            letterKMiddle.press(forDuration: pressDuration, thenDragTo: letterKUp)
            letterKMiddle.press(forDuration: pressDuration, thenDragTo: letterKCross)
        }
       
    }
}

extension XCUIElement {
    func scrollToElement(element: XCUIElement) {
        while !element.visible() {
            swipeUp()
        }
    }
    
    func visible() -> Bool {
        guard self.exists && !self.frame.isEmpty else { return false }
        return XCUIApplication().windows.element(boundBy: 0).frame.contains(self.frame)
    }
}
