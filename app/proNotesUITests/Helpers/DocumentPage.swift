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
        static let shareButton = "Share"
        static let saveAsImage = "As Images"
        static let saveImageButton = "Save Image"
        static let moments = "Moments"
    }
    
    static func cell() -> XCUIElementQuery {
        return XCUIApplication().collectionViews.cells
    }
    
    static func screen() -> XCUIElement {
        return XCUIApplication()
    }
    
    static func button(button: String) -> XCUIElement {
        return XCUIApplication().buttons[button]
    }
    
    static func slider(slider: String) -> XCUIElement {
        return XCUIApplication().sliders[DocumentPage.Constant.drawSlider]
    }
    
    static func alert() -> XCUIElement {
        return XCUIApplication().alerts.element
    }
}

extension XCTest {
    
    // Creates and opens a document if the app is currently in the document overview
    ///
    /// - returns: the name of the new created document
    @discardableResult
    func createAndOpenDocument() -> String {
        DocumentPage.screen().navigationBars[DocumentPage.Constant.documentOverview].buttons[DocumentPage.Constant.documentAdd].tap()
        let pronotesDocumentViewNavigationBar = DocumentPage.screen().navigationBars[DocumentPage.Constant.documentView]
        let documentName = pronotesDocumentViewNavigationBar.children(matching: .other).element.children(matching: .textField).element.value as! String
        return documentName
    }
    
    /// Deletes the document if the app is currently in the document overview
    ///
    /// - parameter name: of the document
    func deleteDocument(name: String) {
        let documentCell = DocumentPage.screen().collectionViews.textFields[name]
        documentCell.longPress()
        DocumentPage.screen().menuItems[DocumentPage.Constant.deleteButton].tap()
    }
    
    /// Closes the document if the document editor is currently opened
    func closeDocument() {
        let pronotesDocumentViewNavigationBar = DocumentPage.screen().navigationBars[DocumentPage.Constant.documentView]
        pronotesDocumentViewNavigationBar.buttons[DocumentPage.Constant.document].tap()
    }
    
    /// adds a textfield to the current Page if a document is open
    func addTextField() {
        openAddLayerOrPagePopover()
        DocumentPage.screen().tables.staticTexts[DocumentPage.Constant.textField].tap()
    }
    
    
    /// adds a Image from the Photos Library to the current Page if a document is open
    func addImage() {
        let app = DocumentPage.screen()
        openAddLayerOrPagePopover()
        app.tables.staticTexts[DocumentPage.Constant.imageButton].tap()
        app.tables.staticTexts[DocumentPage.Constant.photos].tap()
        getGalleryPermission()
        
        app.tables.buttons[DocumentPage.Constant.moments].tap()
        app.collectionViews.cells.firstMatch.tap()
        
    }
    
    func getGalleryPermission() {
        if DocumentPage.alert().exists {
            DocumentPage.alert().collectionViews.buttons[DocumentPage.Constant.allow].tap()
        }
    }
    /// adds a Sketch Layer to the current Page if a document is open
    func addSketchLayer() {
        openAddLayerOrPagePopover()
        DocumentPage.screen().tables.staticTexts[DocumentPage.Constant.sketchCanvas].tap()
    }
    
    /// adds a empty page to the document if a document is open
    func addEmptyPage() {
        openAddLayerOrPagePopover()
        DocumentPage.screen().tables.staticTexts[DocumentPage.Constant.emptyPage].tap()
    }
    
    
    /// opens the Add layer or Page popover if a document is open
    func openAddLayerOrPagePopover() {
        let pronotesDocumentViewNavigationBar = DocumentPage.screen().navigationBars[DocumentPage.Constant.documentView]
        pronotesDocumentViewNavigationBar.buttons[DocumentPage.Constant.documentAdd].tap()
    }
    
    /// press the layer Button to get back to the page info if a layer is selected
    func pressLayerButton() {
        let pronotesDocumentViewNavigationBar = DocumentPage.screen().navigationBars[DocumentPage.Constant.documentView]
        pronotesDocumentViewNavigationBar.buttons[DocumentPage.Constant.layerIconButton].tap()
    }
    
    func passWelcomeScreen() {
        let welcomeButton = DocumentPage.screen().buttons[DocumentPage.Constant.continueSplashScreen]
        if (welcomeButton.exists) {
            welcomeButton.tap()
        }
    }
    
    func prepareDocument() -> String {
        let documentName = createAndOpenDocument()
        closeDocument()
        return documentName
    }
    
    func changeFileName(newName: String) -> XCUIElement {
        let textField = DocumentPage.screen().navigationBars[DocumentPage.Constant.documentView].children(matching: .other).element.children(matching: .textField).element
        
        textField.tap()
        textField.clearAndEnterText(newName)
        DocumentPage.screen().buttons[DocumentPage.Constant.returnButton].tap()
        return textField
    }
    
    func getCurrentDate() -> String {
        let date = Date()
        let formatter = DateFormatter()
        
        formatter.dateStyle = DateFormatter.Style.short
        formatter.timeStyle = .none
        return formatter.string(from: date)
    }
    
    func moveSlider(position: CGFloat) -> String{
        let slider = DocumentPage.slider(slider: DocumentPage.Constant.drawSlider)
        slider.adjust(toNormalizedSliderPosition: position)
        return slider.value as! String
    }
    
    func chooseBlueColor() {
        let colorView = DocumentPage.screen().scrollViews.collectionViews["colorView"]
        colorView.swipeLeft()
        colorView.children(matching: .cell).element(boundBy: 2).tap()
    }
    
    func enterFullScreen() {
        DocumentPage.screen().buttons[DocumentPage.Constant.fullScreenButton].tap()
    }
    
    func documentDrawingModeOn() {
        DocumentPage.button(button: DocumentPage.Constant.pen).tap()
    }
    
    func colorPallete() -> XCUIElement {
        let colorView = DocumentPage.screen().scrollViews.otherElements.collectionViews["colorView"]
        return colorView.children(matching: .cell).element(boundBy: 2)
    }
    
    func saveImage() {
        let app = DocumentPage.screen()
        app.buttons[DocumentPage.Constant.shareButton].tap()
        app.tables.staticTexts[DocumentPage.Constant.saveAsImage].tap()
        getGalleryPermission()
        app.buttons[DocumentPage.Constant.saveImageButton].tap()
    }
    
    func countPhotosInGallery() -> UInt {
        let app = DocumentPage.screen()
        openAddLayerOrPagePopover()
        
        app.tables.staticTexts[DocumentPage.Constant.imageButton].tap()
        app.tables.staticTexts[DocumentPage.Constant.photos].tap()
        getGalleryPermission()
        
        app.tables.buttons["Camera Roll"].tap()
        return app.collectionViews.cells.count
    }
}
