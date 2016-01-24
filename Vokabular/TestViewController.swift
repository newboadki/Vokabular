//
//  ViewController.swift
//  Vokabular
//
//  Created by Borja Arias Drake on 15/08/2014.
//  Copyright (c) 2014 Borja Arias Drake. All rights reserved.
//

import UIKit
import CoreVokabular

class TestViewController: UIViewController, TestExecutionDelegate
{
    
    // MARK: IB Outlets
    @IBOutlet weak var wording : UILabel!
    @IBOutlet weak var originalWordLabel : UILabel!
    @IBOutlet weak var finalWordTextField : UITextField!
    @IBOutlet weak var correctSolutionLabel : UILabel!

    
    // MARK: Properties
    var testManager : TestExecutionManager?
    var selectedLesson : Dictionary<String, String>?

    
    
    // MARK: View life-cycle
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.title = self.selectedLesson!["displayName"]
        self.testManager = TestExecutionManager(delegate: self, selectedLesson:self.selectedLesson!)
    }
    
    
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated);
        
        // Clear fields
        self.correctSolutionLabel.text = ""
        
        // Bring the keyboard up
        self.finalWordTextField.becomeFirstResponder()

        // Show current word
        self.originalWordLabel.text = self.testManager?.initialWord()?.name as String?
        
        self.navigationItem.rightBarButtonItem?.title = "\(self.testManager!.count)/\(self.testManager!.total)"
    }

    
    // MARK: TextField Delegate
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool
    {
        self.testManager!.processGivenAnswer(self.finalWordTextField.text!)
        return true
    }
    
    
    // MARK: TestManagerDelegate
    
    func handleCorrectAnswerWithNextWord(theNextWord : CoreVokabular.Word?)
    {
        if let next = self.testManager!.currentWord?.name {
            self.originalWordLabel.text = next as String
        }

        self.finalWordTextField.text = ""
        self.correctSolutionLabel.text = ""
        self.finalWordTextField.textColor = UIColor(red: 0.0, green: 122/255.0, blue: 255.0/255.0, alpha: 1.0)
        
        if (theNextWord == nil)
        {
            // We are done, show score
            self.wording.text = "Score"
            self.originalWordLabel.text = self.testManager!.numberOfCorrectAnswers.description + " / " + self.testManager!.total.description
            self.finalWordTextField.resignFirstResponder()
        }
        
        self.navigationItem.rightBarButtonItem?.title = "\(self.testManager!.count)/\(self.testManager!.total)"
    }
    
    func handleFailedAttemptWithCorrectAnswer(correctAnswer : String)
    {
        self.correctSolutionLabel.text = correctAnswer
        self.finalWordTextField.textColor = UIColor(red: 200.0/255.0, green: 12/255.0, blue: 80.0/255.0, alpha: 1.0)
        
        UIView.animateKeyframesWithDuration(0.15, delay: 0, options: .Autoreverse, animations: { () -> Void in
            
            UIView.addKeyframeWithRelativeStartTime(0, relativeDuration: 0.5, animations: { () -> Void in
                var frame = self.finalWordTextField.frame
                frame.origin.x -= 20
                self.finalWordTextField.frame = frame
            });
            
            UIView.addKeyframeWithRelativeStartTime(0.5, relativeDuration: 0.5, animations: { () -> Void in
                var frame = self.finalWordTextField.frame
                frame.origin.x += 20
                self.finalWordTextField.frame = frame
            });
            
            
        }, completion: nil)
    }
}

