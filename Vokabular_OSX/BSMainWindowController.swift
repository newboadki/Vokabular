//
//  BSMainWindowController.swift
//  Vokabular
//
//  Created by Borja Arias Drake on 10/11/2014.
//  Copyright (c) 2014 Borja Arias Drake. All rights reserved.
//

import Cocoa
import AppKit

class BSMainWindowController: NSWindowController {
 
    @IBOutlet weak var progressTextField : NSTextField!
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder:aDecoder)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("handleCorrectAnswer:"), name: "kUserSubmittedCorrectAnswerNotification", object: nil)
    }

    
    func handleCorrectAnswer(notification :NSNotification) {
        
        let userInfo = notification.userInfo
        var progressTextFieldCell : NSTextFieldCell = self.progressTextField.cell() as NSTextFieldCell
        let count: AnyObject? = userInfo!["kCount"]
        let total: AnyObject? = userInfo!["kTotal"]
        progressTextFieldCell.title = "\(count!) / \(total!)"
    }
}
