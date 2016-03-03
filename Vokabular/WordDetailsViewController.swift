//
//  WordDetailsViewController.swift
//  Vokabular
//
//  Created by Borja Arias Drake on 09/01/16.
//  Copyright © 2016 Borja Arias Drake. All rights reserved.
//

import UIKit

class WordDetailsViewController: UIViewController
{
    @IBOutlet weak var wordLabel : UILabel!
    @IBOutlet weak var translationLabel : UILabel!
    @IBOutlet weak var wordTypeView: WordTypeView!
    
    internal var wordText : String = ""
    internal var translationText : String = ""
    internal var page : Int?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.wordLabel.text = self.wordText
        self.translationLabel.text = self.translationText
        self.wordTypeView.borderColor = UIColor.purpleColor().colorWithAlphaComponent(0.6)
        self.wordTypeView.backgroundColor = UIColor.purpleColor().colorWithAlphaComponent(0.3)
        self.wordTypeView.cornerRadius = 4
        self.wordTypeView.text = "n"
        self.wordTypeView.alpha = 0
    }
    
    override func viewDidAppear(animated: Bool)
    {

        super.viewDidAppear(animated)
        
//        UIView.animateKeyframesWithDuration(1, delay: 0, options: .CalculationModeCubic, animations: { () -> Void in
//            
//            UIView.addKeyframeWithRelativeStartTime(0, relativeDuration: 0.7, animations: { () -> Void in
//                self.wordTypeView.alpha = 1
//                self.wordTypeView.transform = CGAffineTransformMakeScale(2, 2)
//
//            });
//            
//            UIView.addKeyframeWithRelativeStartTime(0.5, relativeDuration: 0.3, animations: { () -> Void in
//                self.wordTypeView.alpha = 0
//                self.wordTypeView.transform = CGAffineTransformIdentity
//
//            });
//            
//            
//            }, completion: nil)
    }

}
