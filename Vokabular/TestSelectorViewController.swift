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
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 80
        
        NotificationCenter.default().addObserver(self, selector: #selector(TestSelectorViewController.preferredContentSizeChanged(_:)), name: NSNotification.Name.UIContentSizeCategoryDidChange, object: nil)

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.index = WordParser.lessonsIndexArrayWithIndexFileName("index")
        self.tableView.reloadData()

    }

    
    func preferredContentSizeChanged(_ notif : Notification) {
        self.view.needsUpdateConstraints()
        
    }
    

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }

    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.index.count
    }

    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath)
    {
        let lessonCell = cell as! LessonCellTableViewCell
        let lesson : NSDictionary = (self.index[(indexPath as NSIndexPath).row] as! NSDictionary)
        lessonCell.lessonTitle?.text = (lesson["displayName"] as! String)
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        return tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as UITableViewCell
    }
    


    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: AnyObject!)
    {
        let selectedCell = sender.superview?!.superview?.superview as! UITableViewCell
        let indexPath = self.tableView.indexPath(for: selectedCell)
        
        if segue.identifier?.compare("showList") == .orderedSame
        {
            let nextViewController = segue.destinationViewController as! PageViewController
            nextViewController.selectedLesson = (self.index[(indexPath! as NSIndexPath).row] as! Dictionary<String, String>)
        }
        else if segue.identifier?.compare("showTest") == .orderedSame
        {
            let nextViewController = segue.destinationViewController as! TestViewController
            nextViewController.selectedLesson = (self.index[(indexPath! as NSIndexPath).row] as! Dictionary<String, String>)
        }        
    }
    
    // MARK: - IB action
    
    @IBAction func handleDelete(_ sender: UIBarButtonItem) {
        WordParser.deleteContentsOfImportedFiles()
        self.index = WordParser.lessonsIndexArrayWithIndexFileName("index")
        self.tableView.reloadData()
    }
    

}
