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

    var index : NSArray
    
    
    required init?(coder aDecoder: NSCoder)
    {
        self.index = WordParser.lessonsIndexArrayWithIndexFileName("index")
        super.init(coder:aDecoder)
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.title = "Izaberi"
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "preferredContentSizeChanged:", name: UIContentSizeCategoryDidChangeNotification, object: nil)

    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        self.index = WordParser.lessonsIndexArrayWithIndexFileName("index")
        self.tableView.reloadData()

    }

    
    func preferredContentSizeChanged(notif : NSNotification) {
        self.view.needsUpdateConstraints()
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
        let lessonCell = cell as! LessonCellTableViewCell
        let lesson : NSDictionary = (self.index[indexPath.row] as! NSDictionary)
        lessonCell.lessonTitle?.text = (lesson["displayName"] as! String)
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        return tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as UITableViewCell
    }
    


    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!)
    {
        let selectedCell = sender.superview?!.superview?.superview as! UITableViewCell
        let indexPath = self.tableView.indexPathForCell(selectedCell)
        
        if segue.identifier?.compare("showList") == .OrderedSame
        {
            let nextViewController = segue.destinationViewController as! PageViewController
            nextViewController.selectedLesson = (self.index[indexPath!.row] as! Dictionary<String, String>)
        }
        else if segue.identifier?.compare("showTest") == .OrderedSame
        {
            let nextViewController = segue.destinationViewController as! TestViewController
            nextViewController.selectedLesson = (self.index[indexPath!.row] as! Dictionary<String, String>)
        }        
    }
    
    // MARK: - IB action
    
    @IBAction func handleDelete(sender: UIBarButtonItem) {
        WordParser.deleteContentsOfImportedFiles()
        self.index = WordParser.lessonsIndexArrayWithIndexFileName("index")
        self.tableView.reloadData()
    }
    

}
