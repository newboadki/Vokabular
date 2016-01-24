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

    internal var wordText : String = ""
    internal var translationText : String = ""
    internal var page : Int?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.wordLabel.text = self.wordText
        self.translationLabel.text = self.translationText
    }
}
