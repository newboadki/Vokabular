//
//  TestSelectorViewController.swift
//  Vokabular
//
//  Created by Borja Arias Drake on 06/09/2014.
//  Copyright (c) 2014 Borja Arias Drake. All rights reserved.
//

import UIKit
import CoreVokabular

class TestSelectorViewController: UITableViewController
{

    let index : NSArray
    
    
    required init(coder aDecoder: NSCoder)
    {
        self.index = WordParser.lessonsIndexArray()
        super.init(coder:aDecoder)
    }

    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.title = "Izaberi"

    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    
        
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.index.count
    }

    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath)
    {
        var lesson : NSDictionary = (self.index[indexPath.row] as! NSDictionary)
        cell.textLabel?.text = (lesson["displayName"] as! String)
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as! UITableViewCell

        // Configure the cell...

        return cell
    }
    



    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        
        let selectedCell = sender as! UITableViewCell
        let indexPath = self.tableView.indexPathForCell(selectedCell)
        let myVC = segue.destinationViewController as! TestViewController
        myVC.selectedLesson = (self.index[indexPath!.row] as! Dictionary<String, String>)
    }


}
