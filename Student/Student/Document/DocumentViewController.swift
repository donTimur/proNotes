//
//  DocumentViewController.swift
//  Student
//
//  Created by Leo Thomas on 28/11/15.
//  Copyright © 2015 leonardthomas. All rights reserved.
//

import UIKit

class DocumentViewController: UIViewController, PagesOverviewTableViewCellDelegate, DocumentSynchronizerDelegate {

    var pagesOverviewController: PagesOverviewTableViewController?
    var pagesTableViewController: PagesTableViewController?

    var document: Document? = DocumentSynchronizer.sharedInstance.document
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DocumentSynchronizer.sharedInstance.addDelegate(self)
        document = DocumentSynchronizer.sharedInstance.document
        pagesTableViewController?.document = document
    }

    deinit {
        DocumentSynchronizer.sharedInstance.removeDelegate(self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func handleAddPageButtonPressed(sender: AnyObject) {
        document?.addEmptyPage()
        DocumentSynchronizer.sharedInstance.document = document
    }

    @IBAction func handleDrawButtonPressed(sender: AnyObject) {
    
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let viewController = segue.destinationViewController as? PagesOverviewTableViewController {
            viewController.pagesOverViewDelegate = self
            pagesOverviewController = viewController
        } else if let viewController = segue.destinationViewController as? PagesTableViewController {
            pagesTableViewController = viewController
        }
    }
    
    // MARK: - PagesOverViewDelegate
    
    func showPage(index: Int){
        pagesTableViewController?.showPage(index)
    }
    
    // MARK: - DocumentSynchronizerDelegate
    func updateDocument(document: Document, forceReload: Bool){
        self.document = document
    }
    
}
