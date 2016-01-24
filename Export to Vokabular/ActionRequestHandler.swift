//
//  ActionRequestHandler.swift
//  Export to Vokabular
//
//  Created by Borja Arias Drake on 08/03/15.
//  Copyright (c) 2015 Borja Arias Drake. All rights reserved.
//

import UIKit
import MobileCoreServices

class ActionRequestHandler: NSObject, NSExtensionRequestHandling
{    
    var extensionContext: NSExtensionContext?
    
    func beginRequestWithExtensionContext(context: NSExtensionContext)
    {
        // Do not call super in an Action extension with no user interface
        
        self.extensionContext = context
        
        let textItem = self.extensionContext!.inputItems[0] as! NSExtensionItem
        
        let textItemProvider = textItem.attachments![0] as! NSItemProvider
        
        if textItemProvider.hasItemConformingToTypeIdentifier(kUTTypeText as String)
        {
            textItemProvider.loadItemForTypeIdentifier(kUTTypeText as String, options: nil, completionHandler: { (text, error) -> Void in
                self.handleCompletion(text, error: error)
            })
        }
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
        let sharedUserDefault : NSUserDefaults? = NSUserDefaults(suiteName: "group.vokabular.extension")
        sharedUserDefault!.setObject(components, forKey: "lastImports")

    

        // THIS IS A TEST TO OPEN THE HOST APP
        //A Today widget (and no other app extension type) can ask the system to open its containing app by calling the openURL:completionHandler: method of the NSExtensionContext class.
        // self.extensionContext?.openURL(NSURL(string: "vk://")!, completionHandler: { (success) -> Void in
        //})

        // MARK AS COMPLETED
        self.extensionContext!.completeRequestReturningItems([], completionHandler: nil)
        self.extensionContext = nil // Don't hold on to this after we finished with it.
    }

}
