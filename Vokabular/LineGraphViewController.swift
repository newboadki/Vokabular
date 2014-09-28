//
//  LineGraphViewController.swift
//  Vokabular
//
//  Created by Borja Arias Drake on 27/09/2014.
//  Copyright (c) 2014 Borja Arias Drake. All rights reserved.
//

import UIKit
import BSGraphKit

class LineGraphViewController: UIViewController, LineGraphDataSourceProtocol {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    override func loadView() {

//        var lineGraph = LineGraph(frame: CGRectZero)
//        lineGraph.dataSource = self
//        self.view = lineGraph

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    func moneyIn() -> [AnyObject]!
    {
        return [23, 40, 33, 50]
    }
    
    func moneyOut() -> [AnyObject]!
    {
        return [13, 13, 13, 13]
    }

    func xValues() -> [AnyObject]!
    {
        return ["Monday", "Tuesday", "Wed", "Thur"]
    }

    func graphTitle() -> String!
    {
        return "Score"
    }
    
    
}
