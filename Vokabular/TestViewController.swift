//
//  ViewController.swift
//  Vokabular
//
//  Created by Borja Arias Drake on 15/08/2014.
//  Copyright (c) 2014 Borja Arias Drake. All rights reserved.
//

import UIKit

class TestViewController: UIViewController
{
    @IBOutlet weak var wording : UILabel!
    @IBOutlet weak var originalWordLabel : UILabel!
    @IBOutlet weak var finalWordTextField : UITextField!
    @IBOutlet weak var correctSolutionLabel : UILabel!
    
    var wordGenerator : WordGenerator?
    var currentWord : Word?
    var previousWord : Word?
    var numberOfHits : Int = 0
    var total : Int = 0
    var count : Int = 0
    var selectedKey : String?
    
    required init(coder aDecoder: (NSCoder!)) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        var parser = WordParser()
        var words = parser.parseWordsFromFileWithIndexKey(self.selectedKey!)
        self.total = words.count
        self.count = 1
        self.wordGenerator = WordGenerator(words: words, numberOfWordsToGenerate: total)
        self.currentWord = self.wordGenerator!.nextWord()!
        self.title = self.selectedKey!

        
        self.navigationItem.rightBarButtonItem?.title = "\(self.count)/\(self.total)"
    }
    
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated);
        
        // Clear fields
        self.correctSolutionLabel.text = ""
        
        // Bring the keyboard up
        self.finalWordTextField.becomeFirstResponder()

        // Show current word
        self.originalWordLabel.text = self.currentWord?.name
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    
    }

    
    func textFieldShouldReturn(textField: UITextField!) -> Bool
    {
    
        var correctAnswer : String? = self.currentWord?.synonyms[0]
        var givenAnswer : String = self.finalWordTextField.text
        correctAnswer = correctAnswer?.lowercaseString.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        givenAnswer = givenAnswer.lowercaseString.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        
        
        
        if givenAnswer == correctAnswer
        {
            if (self.previousWord != self.currentWord)
            {
                self.numberOfHits = self.numberOfHits + 1
            }
            self.previousWord = self.currentWord // Store the old one
            self.currentWord = self.wordGenerator!.nextWord()?
            self.originalWordLabel.text = self.currentWord?.name
            self.finalWordTextField.text = ""
            self.correctSolutionLabel.text = ""
            self.finalWordTextField.textColor = UIColor(red: 0.0, green: 122/255.0, blue: 255.0/255.0, alpha: 1.0)
            
            if (self.currentWord == nil)
            {
                // We are done, show score
                self.wording.text = "Score"
                self.originalWordLabel.text = self.numberOfHits.description + " / " + self.total.description
            }
            
            self.count += 1
            self.navigationItem.rightBarButtonItem?.title = "\(self.count)/\(self.total)"
        }
        else
        {
            self.previousWord = self.currentWord // Store the old one
            self.correctSolutionLabel.text = correctAnswer
            
            UIView.animateKeyframesWithDuration(0.2, delay: 0, options: .Autoreverse, animations: { () -> Void in
                
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
            

            self.finalWordTextField.textColor = UIColor.redColor()
        }
        
        
        
        return true
    }

}

