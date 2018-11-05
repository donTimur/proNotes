//
//  Document+XCUIElementExtension.swift
//  proNotesUITests
//
//  Created by Timur Khasanov on 11/5/18.
//  Copyright © 2018 leonardthomas. All rights reserved.
//
import XCTest

extension XCUIElement
{
    enum letters : Int {
        case V, K
    }
    
    func pressAndDragTo(_ letter : letters) {
        let start: CGFloat = 0.15
        let step : CGFloat = 0.2
        let offset : CGFloat = 0.05
        let pressDuration : TimeInterval = 0.1
        
        let startPosition = start + step
        
        let KLowestPosition = startPosition + step + offset
        let KMiddlePosition = startPosition - 0.1
        
        let letterV = self.coordinate(withNormalizedOffset: CGVector(dx: start, dy: start))
        let letterMiddleV = self.coordinate(withNormalizedOffset: CGVector(dx: startPosition, dy: startPosition))
        let letterEndV = self.coordinate(withNormalizedOffset: CGVector(dx: startPosition + step, dy: start))
        
        let startK = self.coordinate(withNormalizedOffset: CGVector(dx: KLowestPosition, dy: start))
        let KDown = self.coordinate(withNormalizedOffset: CGVector(dx: KLowestPosition, dy: startPosition))
        let KMiddle = self.coordinate(withNormalizedOffset: CGVector(dx: KLowestPosition, dy: KMiddlePosition))
        let KCrossUp = self.coordinate(withNormalizedOffset: CGVector(dx: KLowestPosition + step, dy: start))
        let KCrossDown = self.coordinate(withNormalizedOffset: CGVector(dx: KLowestPosition + step, dy: start+step))
        
        switch letter {
        case .V:
            letterV.press(forDuration: pressDuration, thenDragTo: letterMiddleV)
            letterMiddleV.press(forDuration: pressDuration, thenDragTo: letterEndV)
            break
        case .K:
            startK.press(forDuration: pressDuration, thenDragTo: KDown)
            KMiddle.press(forDuration: pressDuration, thenDragTo: KCrossUp)
            KMiddle.press(forDuration: pressDuration, thenDragTo: KCrossDown)
        }
        
    }
}

extension XCUIElement {
    
    /// Removes any current text in the field before typing in the new value
    ///
    /// - parameter text: the text to enter into the field
    func clearAndEnterText(_ text: String) -> Void {
        guard let stringValue = self.value as? String else {
            XCTFail("Tried to clear and enter text into a non string value")
            return
        }
        
        self.tap()
        
        var deleteString: String = ""
        for _ in stringValue {
            deleteString += "\u{8}"
        }
        self.typeText(deleteString)
        
        self.typeText(text)
    }
    
    func longPress() {
        press(forDuration: 1)
    }
}

