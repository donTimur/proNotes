//
//  DocumentPage.swift
//  proNotesUITests
//
//  Created by Timur Khasanov on 10/31/18.
//  Copyright © 2018 leonardthomas. All rights reserved.
//

import XCTest

class DocumentPage {
    struct Constant {
        static let documentOverview = "proNotes.DocumentOverviewView"
        static let documentAdd = "Add"
        static let documentView = "proNotes.DocumentView"
        static let document = "Documents"
        static let textField = "Textfield"
        static let imageButton = "Image"
        static let imageLayer = "image"
        static let photos = "Photos"
        static let allow = "Allow"
        static let sketchCanvas = "Sketch Canvas"
        static let emptyPage = "Empty Page"
        static let continueSplashScreen = "welcomeButton"
        static let returnButton = "Return"
        static let cancelButton = "Cancel"
        static let overrideButton = "Override"
        static let deleteButton = "Delete"
        static let layerIconButton = "layerIcon"
        static let fullScreenButton = "fullScreenButton"
        static let documentLayers = "Layers"
        static let drawSlider = "drawSlider"
        static let pen = "pen"
        static let documentCanvas = "documentCanvas"
    }
}


extension XCTest {
    
    // Creates and opens a document if the app is currently in the document overview
    ///
    /// - returns: the name of the new created document
    @discardableResult
    func createAndOpenDocument(app: XCUIApplication) -> String {
        app.navigationBars[DocumentPage.Constant.documentOverview].buttons[DocumentPage.Constant.documentAdd].tap()
        let pronotesDocumentViewNavigationBar = app.navigationBars[DocumentPage.Constant.documentView]
        let documentName = pronotesDocumentViewNavigationBar.children(matching: .other).element.children(matching: .textField).element.value as! String
        return documentName
    }
    
    /// Deletes the document if the app is currently in the document overview
    ///
    /// - parameter name: of the document
    func deleteDocument(name: String, app: XCUIApplication) {
        let documentCell = app.collectionViews.textFields[name]
        documentCell.longPress()
        app.menuItems[DocumentPage.Constant.deleteButton].tap()
    }
    
    /// Closes the document if the document editor is currently opened
    func closeDocument(app: XCUIApplication) {
        let pronotesDocumentViewNavigationBar = app.navigationBars[DocumentPage.Constant.documentView]
        pronotesDocumentViewNavigationBar.buttons[DocumentPage.Constant.document].tap()
    }
    
    /// adds a textfield to the current Page if a document is open
    func addTextField(app: XCUIApplication) {
        openAddLayerOrPagePopover(app: app)
        app.tables.staticTexts[DocumentPage.Constant.textField].tap()
    }
    
    
    /// adds a Image from the Photos Library to the current Page if a document is open
    func addImage(app: XCUIApplication) {
        openAddLayerOrPagePopover(app: app)
        app.tables.staticTexts[DocumentPage.Constant.imageButton].tap()
        app.tables.staticTexts[DocumentPage.Constant.photos].tap()
        if app.alerts.element.exists {
            app.alerts.element.collectionViews.buttons[DocumentPage.Constant.allow].tap()
        }
        
        app.tables.buttons["Moments"].tap()
        app.collectionViews.cells.firstMatch.tap()
        
    }
    
    /// adds a Sketch Layer to the current Page if a document is open
    func addSketchLayer(app: XCUIApplication) {
        openAddLayerOrPagePopover(app: app)
        app.tables.staticTexts[DocumentPage.Constant.sketchCanvas].tap()
    }
    
    /// adds a empty page to the document if a document is open
    func addEmptyPage(app: XCUIApplication) {
        openAddLayerOrPagePopover(app: app)
        app.tables.staticTexts[DocumentPage.Constant.emptyPage].tap()
    }
    
    
    /// opens the Add layer or Page popover if a document is open
    func openAddLayerOrPagePopover(app: XCUIApplication) {
        let pronotesDocumentViewNavigationBar = app.navigationBars[DocumentPage.Constant.documentView]
        pronotesDocumentViewNavigationBar.buttons[DocumentPage.Constant.documentAdd].tap()
    }
    
    /// press the layer Button to get back to the page info if a layer is selected
    func pressLayerButton(app: XCUIApplication) {
        let pronotesDocumentViewNavigationBar = app.navigationBars[DocumentPage.Constant.documentView]
        pronotesDocumentViewNavigationBar.buttons[DocumentPage.Constant.layerIconButton].tap()
    }
    
    func passWelcomeScreen(app: XCUIApplication) {
        let welcomeButton = app.buttons[DocumentPage.Constant.continueSplashScreen]
        if (welcomeButton.exists) {
            welcomeButton.tap()
        }
    }
    
    func prepareDocument(app: XCUIApplication) -> String {
        let documentName = createAndOpenDocument(app: app)
        closeDocument(app: app)
        return documentName
    }
    
    func changeFileName(app: XCUIApplication, newName: String) -> XCUIElement {
        let textField = app.navigationBars[DocumentPage.Constant.documentView].children(matching: .other).element.children(matching: .textField).element
        
        textField.tap()
        textField.clearAndEnterText(newName)
        app.buttons[DocumentPage.Constant.returnButton].tap()
        return textField
    }
    
    func getCurrentDate() -> String {
        let date = Date()
        let formatter = DateFormatter()
        
        formatter.dateFormat = "MM/dd/yy"
        return formatter.string(from: date)
    }
    
    func moveSlider(slider: XCUIElement, position: CGFloat) -> String{
        slider.adjust(toNormalizedSliderPosition: position)
        return slider.value as! String
    }
}


// From StackOverflow User bay.phillips http://stackoverflow.com/a/32894080

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