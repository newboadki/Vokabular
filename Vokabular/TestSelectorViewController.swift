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

    var index : Array<[String : String]>
    
   

    required init?(coder aDecoder: NSCoder)
    {
        self.index = WordParser().lessonsIndex
        super.init(coder:aDecoder)
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.title = "Izaberi"
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 80
        
        NotificationCenter.default.addObserver(self, selector: #selector(TestSelectorViewController.preferredContentSizeChanged(_:)), name: NSNotification.Name.UIContentSizeCategoryDidChange, object: nil)

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }

    
    @objc func preferredContentSizeChanged(_ notif : Notification) {
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
        let lesson = (self.index[(indexPath as NSIndexPath).row])
        lessonCell.lessonTitle?.text = (lesson["displayName"])
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        return tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as UITableViewCell
    }
    


    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let view = sender as! UIView
        let selectedCell = view.superview?.superview?.superview as! UITableViewCell
        let indexPath = self.tableView.indexPath(for: selectedCell)

        if segue.identifier?.compare("showList") == .orderedSame
        {
            let nextViewController = segue.destination as! PageViewController
            nextViewController.selectedLesson = (self.index[(indexPath! as NSIndexPath).row])
        }
        else if segue.identifier?.compare("showTest") == .orderedSame
        {
            let nextViewController = segue.destination as! TestViewController
            nextViewController.selectedLesson = (self.index[(indexPath! as NSIndexPath).row])
        }

    }
    
    // MARK: - IB action
    
    @IBAction func handleDelete(_ sender: UIBarButtonItem) {
        FileSystemHelper.deleteContentsOf(directoryName: "importedVokabularFiles")        
        self.index = WordParser().lessonsIndex
        self.tableView.reloadData()
    }
    

}
