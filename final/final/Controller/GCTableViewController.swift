//
//  ViewController.swift
//  final
//
//  Created by Tyler Mabey on 12/18/17.
//  Copyright © 2017 Tyler Mabey. All rights reserved.
//

import UIKit

class GCTableViewController: UIViewController {
    var lastText: String = ""
    var conferences = [(Int, String)]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        lastText = DatabaseAccess.sharedDatabaseAccess.lastUpdated()
        
        conferences = DatabaseAccess.sharedDatabaseAccess.getAllConferences()
        for c in conferences {
            print(c)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    
    
    
}

