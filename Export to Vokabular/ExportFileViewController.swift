//
//  ExportFileViewController.swift
//  Vokabular
//
//  Created by Borja Arias Drake on 25/01/16.
//  Copyright © 2016 Borja Arias Drake. All rights reserved.
//

import UIKit
import MobileCoreServices

class ExportFileViewController: UIViewController {
    //var extensionContext: NSExtensionContext?

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    

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
        //self.extensionContext = nil // Don't hold on to this after we finished with it.
    }

}
