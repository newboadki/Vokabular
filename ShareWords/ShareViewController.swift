//
//  ShareViewController.swift
//  Pocoyo
//
//  Created by Borja Arias Drake on 28/01/16.
//  Copyright © 2016 Borja Arias Drake. All rights reserved.
//

import UIKit
import Social
import MobileCoreServices


class ShareViewController: SLComposeServiceViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.textView.text = "Title"
        self.placeholder = "Title"
    }
    
    override func isContentValid() -> Bool {
        // Do validation of contentText and/or NSExtensionContext attachments here
        return true
    }
    
    override func didSelectPost() {
                
        // This is called after the user selects Post. Do the upload of contentText and/or NSExtensionContext attachments.
        
        // Inform the host that we're done, so it un-blocks its UI. Note: Alternatively you could call super's -didSelectPost, which will similarly complete the extension context.
        
        let textItem = self.extensionContext!.inputItems[0] as! NSExtensionItem
        
        let textItemProvider = textItem.attachments![0] as! NSItemProvider
        
        if textItemProvider.hasItemConformingToTypeIdentifier(kUTTypePlainText as String)
        {
            textItemProvider.loadItemForTypeIdentifier(kUTTypePlainText as String, options: nil, completionHandler: { (text, error) -> Void in
                self.handleCompletion(text, error: error)
            })
        }
        
        
    }
    
    override func loadPreviewView() -> UIView! {
        return nil
    }
    
    override func configurationItems() -> [AnyObject]! {
        // To add configuration options via table cells at the bottom of the sheet, return an array of SLComposeSheetConfigurationItem here.
        return []
    }
    
    func handleCompletion(string: NSSecureCoding!, error: NSError!)
    {
        var inputString : String? = string as? String
        
        
        // PARSE
        inputString = inputString?.stringByReplacingOccurrencesOfString("<html>", withString: "", options: [], range: nil)
        inputString = inputString?.stringByReplacingOccurrencesOfString("</html>", withString: "", options: [], range: nil)
        
        inputString = inputString?.stringByReplacingOccurrencesOfString("<head>", withString: "", options: [], range: nil)
        inputString = inputString?.stringByReplacingOccurrencesOfString("</head>", withString: "", options: [], range: nil)
        
        inputString = inputString?.stringByReplacingOccurrencesOfString("<body>", withString: "", options: [], range: nil)
        inputString = inputString?.stringByReplacingOccurrencesOfString("</body>", withString: "", options: [], range: nil)
        
        inputString = inputString?.stringByReplacingOccurrencesOfString("<div>", withString: "", options: [], range: nil)
        
        
        // FILTER
        var components = inputString?.componentsSeparatedByString("</div>")
        components = components?.filter({ (par : String) -> Bool in
            return (par != "")
        })
        
        // SHARE WITH CONTAINING APP
//        let sharedUserDefault : NSUserDefaults? = NSUserDefaults(suiteName: "group.vokabular.extension")
//
//        var exportedLists : Dictionary<String , [String]> = (sharedUserDefault?.objectForKey("lastImports"))!.copy() as! Dictionary<String, [String]>
//        exportedLists[self.textView.text!] = components!
//        sharedUserDefault!.setObject(exportedLists, forKey: "lastImports")

        let sharedUserDefault : NSUserDefaults? = NSUserDefaults(suiteName: "group.vokabular.extension")
        if var exportedLists = sharedUserDefault?.objectForKey("lastImports") as! Dictionary<String, [String]>? {
            exportedLists[self.textView.text!] = components!
            sharedUserDefault!.setObject(exportedLists, forKey: "lastImports")
            
        } else {
            sharedUserDefault!.setObject([:], forKey: "lastImports")
            
        }

        
        // THIS IS A TEST TO OPEN THE HOST APP
        //A Today widget (and no other app extension type) can ask the system to open its containing app by calling the openURL:completionHandler: method of the NSExtensionContext class.
        // self.extensionContext?.openURL(NSURL(string: "vk://")!, completionHandler: { (success) -> Void in
        //})
        
        // MARK AS COMPLETED
        self.extensionContext!.completeRequestReturningItems([], completionHandler: nil)
        //self.extensionContext = nil // Don't hold on to this after we finished with it.
    }
    
}
