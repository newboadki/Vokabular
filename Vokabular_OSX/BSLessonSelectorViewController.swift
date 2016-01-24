//
//  BSLessonSelectorViewController.swift
//  Vokabular
//
//  Created by Borja Arias Drake on 21/03/15.
//  Copyright (c) 2015 Borja Arias Drake. All rights reserved.
//

import Cocoa
import AppKit

class BSLessonSelectorViewController: NSViewController {
 
    internal var lessonsInfo : Array<[String : String]>
    
    required init?(coder aDecoder: NSCoder)
    {
        lessonsInfo = []
        super.init(coder:aDecoder)
    }

    
}
