//
//  PageViewController.swift
//  Vokabular
//
//  Created by Borja Arias Drake on 08/01/16.
//  Copyright © 2016 Borja Arias Drake. All rights reserved.
//

import UIKit
import CoreVokabular

class PageViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource, TestExecutionDelegate
{

    // MARK: IB Outlets
    @IBOutlet weak var originalWordLabel : UILabel!
    @IBOutlet weak var finalWordTextField : UITextField!

    
    
    // MARK: Properties
    var testManager : TestExecutionManager?
    var selectedLesson : Dictionary<String, String>?
    var viewControllersList : Array<UIViewController>?
    var currentIndex : Int = 0

    
    // MARK: View life-cycle
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.title = self.selectedLesson!["displayName"]
        self.testManager = TestExecutionManager(delegate: self, selectedLesson:self.selectedLesson!)
        self.delegate = self
        self.dataSource = self


        let parser = WordParser()
        let words = parser.parseWordsFromFileInfo(self.selectedLesson!)
        
        self.viewControllersList = []
        for index in 0...(words.count-1)
        {
            let word : CoreVokabular.Word = words[index]
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "WordDetailsViewController") as! WordDetailsViewController
            vc.page = index
            
            
            vc.wordText = word.synonyms.first!
            vc.translationText = word.name! as String
            self.viewControllersList?.append(vc)
        }
        
        self.navigationItem.rightBarButtonItem?.title = "\(self.currentIndex+1)/\(self.testManager!.total)"
        self.setViewControllers([self.viewControllersList![0]], direction:.forward, animated: true, completion: nil)
        
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    

    // MARK: - UIPageViewControllerDataSource
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController?
    {
        
        let currentVC = viewController as! WordDetailsViewController
        if currentVC.page! > 0 {
            self.currentIndex = self.currentIndex - 1
            self.navigationItem.rightBarButtonItem?.title = "\(self.currentIndex)/\(self.testManager!.total)"
            
            return self.viewControllersList![currentVC.page!-1]
        } else {
            self.navigationItem.rightBarButtonItem?.title = "\(0)/\(self.testManager!.total)"
            return nil
        }
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController?
    {
        let currentVC = viewController as! WordDetailsViewController
        if currentVC.page! < self.testManager!.total-1 {
            self.currentIndex = self.currentIndex + 1
            self.navigationItem.rightBarButtonItem?.title = "\(self.currentIndex)/\(self.testManager!.total)"
            
            return self.viewControllersList![currentVC.page!+1]
        } else {
            self.navigationItem.rightBarButtonItem?.title = "\(self.testManager!.total)/\(self.testManager!.total)"
            return nil
        }
    }
    
    

    
    
    // MARK: TestManagerDelegate
    
    func handleCorrectAnswerWithNextWord(_ theNextWord : CoreVokabular.Word?)
    {
    }
    
    func handleFailedAttemptWithCorrectAnswer(_ correctAnswer : String)
    {
    }
}
