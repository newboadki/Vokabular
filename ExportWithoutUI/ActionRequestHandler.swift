//
//  ActionRequestHandler.swift
//  ExportWithoutUI
//
//  Created by Borja Arias Drake on 30/01/16.
//  Copyright © 2016 Borja Arias Drake. All rights reserved.
//

import UIKit
import MobileCoreServices

/* Man cla f a xtenion ithout UI*/
class ActionRequestHandler: NSObject, NSExtensionRequestHandling
{
    var extensionContext: NSExtensionContext?
    
    func beginRequest(with context: NSExtensionContext)
    {
        // Do not call super in an Action extension with no user interface
        
        self.extensionContext = context
        
        let textItem = self.extensionContext!.inputItems[0] as! NSExtensionItem
        
        let textItemProvider = textItem.attachments![0] as! NSItemProvider
        
        if textItemProvider.hasItemConformingToTypeIdentifier(kUTTypeText as String)
        {
            textItemProvider.loadItem(forTypeIdentifier: kUTTypeText as String, options: nil, completionHandler: { (text, error) -> Void in
                self.handleCompletion(text, error: error)
            })
        }
    }
    
    func handleCompletion(_ string: NSSecureCoding!, error: NSError!)
    {
        var inputString : String? = string as? String
        
        
        // PARSE
        inputString = inputString?.replacingOccurrences(of: "<html>", with: "", options: [], range: nil)
        inputString = inputString?.replacingOccurrences(of: "</html>", with: "", options: [], range: nil)
        
        inputString = inputString?.replacingOccurrences(of: "<head>", with: "", options: [], range: nil)
        inputString = inputString?.replacingOccurrences(of: "</head>", with: "", options: [], range: nil)
        
        inputString = inputString?.replacingOccurrences(of: "<body>", with: "", options: [], range: nil)
        inputString = inputString?.replacingOccurrences(of: "</body>", with: "", options: [], range: nil)
        
        inputString = inputString?.replacingOccurrences(of: "<div>", with: "", options: [], range: nil)
        
        
        // FILTER
        var components = inputString?.components(separatedBy: "</div>")
        components = components?.filter({ (par : String) -> Bool in
            return (par != "")
        })
        
        // SHARE WITH CONTAINING APP
        let sharedUserDefault : UserDefaults? = UserDefaults(suiteName: "group.vokabular.extension")
        sharedUserDefault!.set(components, forKey: "lastImports")
        
        
        
        // THIS IS A TEST TO OPEN THE HOST APP
        //A Today widget (and no other app extension type) can ask the system to open its containing app by calling the openURL:completionHandler: method of the NSExtensionContext class.
        // self.extensionContext?.openURL(NSURL(string: "vk://")!, completionHandler: { (success) -> Void in
        //})
        
        // MARK AS COMPLETED
        self.extensionContext!.completeRequest(returningItems: [], completionHandler: nil)
        self.extensionContext = nil // Don't hold on to this after we finished with it.
    }
    
}

