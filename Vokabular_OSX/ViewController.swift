//
//  ViewController.swift
//  Vokabular_OSX
//
//  Created by Borja Arias Drake on 29/10/2014.
//  Copyright (c) 2014 Borja Arias Drake. All rights reserved.
//

import Cocoa
import AppKit
import CoreVokabularOSX

class ViewController: NSViewController, TestExecutionDelegate
{
    
    @IBOutlet weak var NextButton: NSButton!
    @IBOutlet weak var wording : NSTextField!
    @IBOutlet weak var originalWordLabel : NSTextField!
    @IBOutlet weak var finalWordTextField : NSTextField!
    @IBOutlet weak var correctSolutionLabel : NSTextField!
    @IBOutlet weak var progressButton : NSTextField!
    
    var testManager : TestExecutionManager?
    var selectedLesson : Dictionary<String, String>?
    var index : NSArray?
    
    
    override func viewDidLoad() {
        self.index = WordParser.lessonsIndexArray()
        self.selectedLesson = (self.index![0] as Dictionary<String, String>)
        self.title = self.selectedLesson!["displayName"]
        self.testManager = TestExecutionManager(delegate: self, selectedLesson:self.selectedLesson!)
    }
    
    override var representedObject: AnyObject? {
        didSet {
            // Update the view, if already loaded.
        }
    }
    
    
    @IBAction func nextButtonPressed(sender: NSButton) {
        var finalWordTextFieldCell : NSTextFieldCell = self.finalWordTextField.cell() as NSTextFieldCell
        self.testManager!.processGivenAnswer(finalWordTextFieldCell.title)
    }
    
    // TestManagerDelegate -------------------------------------------------------------------------------------------------
    func handleCorrectAnswerWithNextWord(theNextWord : CoreVokabularOSX.Word?)
    {
        NSNotificationCenter.defaultCenter().postNotificationName("kUserSubmittedCorrectAnswerNotification", object: nil, userInfo: nil)
        
        var finalWordTextFieldCell : NSTextFieldCell = self.finalWordTextField.cell() as NSTextFieldCell
        var originalWordTextFieldCell : NSTextFieldCell = self.originalWordLabel.cell() as NSTextFieldCell
        var correctSolutionTextFieldCell : NSTextFieldCell = self.correctSolutionLabel.cell() as NSTextFieldCell
        var wordingTextFieldCell : NSTextFieldCell = self.wording.cell() as NSTextFieldCell
        self.finalWordTextField.textColor = NSColor(red: 0.0, green: 122/255.0, blue: 255.0/255.0, alpha: 1.0)
        
        if (theNextWord == nil)
        {
            // We are done, show score
            wordingTextFieldCell.title = "Score"
        }
        else
        {
            originalWordTextFieldCell.title = self.testManager!.currentWord!.name!
            finalWordTextFieldCell.title = ""
            correctSolutionTextFieldCell.title = ""
        }
    }
    
    func handleFailedAttemptWithCorrectAnswer(correctAnswer : String)
    {
        var correctSolutionTextFieldCell : NSTextFieldCell = self.correctSolutionLabel.cell() as NSTextFieldCell
        correctSolutionTextFieldCell.title = correctAnswer
    }
    
}