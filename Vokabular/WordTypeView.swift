//
//  WordTypeView.swift
//  Vokabular
//
//  Created by Borja Arias Drake on 20/02/16.
//  Copyright © 2016 Borja Arias Drake. All rights reserved.
//

import UIKit

@IBDesignable class WordTypeView: UIView
{
     @IBInspectable @IBOutlet var textLabel : UILabel?

    @IBInspectable var borderColor : UIColor?
    {
        didSet
        {
            self.layer.borderColor = borderColor?.cgColor
        }
    }
        
    @IBInspectable var borderWitdth : CGFloat = 0.0
    {
        didSet
        {
            self.layer.borderWidth = borderWitdth
        }
        
    }
    
    @IBInspectable var cornerRadius : CGFloat = 0.0
        {
        didSet
        {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    var text : String? // Can't inpect, becaue the label is not connected at deign time by IB
        {
        didSet
        {
            self.textLabel?.text = text
        }

    }
    
}
