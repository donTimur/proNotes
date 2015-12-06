//
//  DocumentSynchronizer.swift
//  Student
//
//  Created by Leo Thomas on 29/11/15.
//  Copyright © 2015 leonardthomas. All rights reserved.
//

import UIKit

extension Array {
    
    func indexOfObject(object : Element) -> NSInteger {
        return self.indexOfObject(object)
    }
    
    func containsObject(object: Any) -> Bool
    {
        if let anObject: AnyObject = object as? AnyObject
        {
            for obj in self
            {
                if let anObj: AnyObject = obj as? AnyObject
                {
                    if anObj === anObject { return true }
                }
            }
        }
        return false
    }
    
    mutating func removeObject(object : Element) {
        for var index = self.indexOfObject(object); index != NSNotFound; index = self.indexOfObject(object) {
            self.removeAtIndex(index)
        }
    }
}

protocol DocumentSynchronizerDelegate {
    func updateDocument(document: Document, forceReload: Bool)
}

class DocumentSynchronizer: NSObject {

    static let sharedInstance = DocumentSynchronizer()
    var delegates = [DocumentSynchronizerDelegate]()

    var document: Document?{
        didSet{
            if document != nil {
                informDelegateToUpdateDocument(document!, forceReload: true)
            }
        }
    }
    
    func updateDrawLayer(drawLayer: DocumentDrawLayer, forceReloead: Bool){
        if document != nil {
            let page = drawLayer.docPage
            page.layer[drawLayer.index] = drawLayer
            document?.pages[page.index] = page
            dispatch_async(dispatch_get_main_queue(),{
                self.informDelegateToUpdateDocument(self.document!, forceReload: forceReloead)
            })

            print("update draw layer"+String(page.index)+String(drawLayer.index))
        }
    }
    
    // MARK: - Delegate Handling
    
    func addDelegate(delegate  :DocumentSynchronizerDelegate) {
        if !delegates.containsObject(delegate) {
            delegates.append(delegate)
        }
    }
    
    func removeDelegate(delegate :DocumentSynchronizerDelegate) {
        delegates.removeObject(delegate)
    }
    
    func informDelegateToUpdateDocument(document :Document, forceReload: Bool) {
        for delegate in delegates {
            delegate.updateDocument(document, forceReload: forceReload)
        }
    }

    
}
