//
//  ViewController.swift
//  Vokabular_OSX
//
//  Created by Borja Arias Drake on 29/10/2014.
//  Copyright (c) 2014 Borja Arias Drake. All rights reserved.
//

import Cocoa
import CoreVokabularOSX

class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var w = CoreVokabularOSX.Word(name: "escoba", synonyms: [""])
        println("La bruja de la \(w.name)")
        // Do any additional setup after loading the view.
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

