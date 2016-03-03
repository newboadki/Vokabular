//
//  AppDelegate.swift
//  Vokabular
//
//  Created by Borja Arias Drake on 15/08/2014.
//  Copyright (c) 2014 Borja Arias Drake. All rights reserved.
//

import UIKit
import CoreVokabular

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
                            
    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject : AnyObject]?) -> Bool {
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication)
    {
        if let userDefaults = NSUserDefaults(suiteName: "group.vokabular.extension")
        {
            if var exportedLists = (userDefaults.objectForKey("lastImports") as! Dictionary<String , [String]>?)
            {
                for (title, words) in exportedLists
                {
                    // Store
                    let (_, _) = WordParser.storeLinesIntoImportedFile(title, lines: words)
                    
                    // Delete from shared user default
                    exportedLists.removeValueForKey(title) // this is considered mutating, therefore the reference is declared as VAR. might have to do with the Dictionary being value type
                }
                
                userDefaults.setObject(exportedLists, forKey: "lastImports") // this is not considered mutating, therefore the reference is declared as LET. Might have to do with  reference type of nsuserdefault
            }
        }
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

