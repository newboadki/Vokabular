//
//  Word.swift
//  Vokabular
//
//  Created by Borja Arias Drake on 15/08/2014.
//  Copyright (c) 2014 Borja Arias Drake. All rights reserved.
//

import UIKit

class Word: NSObject
{
    var name : NSString?
    var synonyms : [String]
    
    init(name: String, synonyms: [String])
    {
        self.name = name
        self.synonyms = synonyms
    }
}
