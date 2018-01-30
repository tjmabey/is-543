//
//  TalksViewController.swift
//  final
//
//  Created by Tyler Mabey on 12/18/17.
//  Copyright © 2017 Tyler Mabey. All rights reserved.
//

import UIKit

class TalksViewController: UITableViewController {
    
    // MARK: - Properties
    var conferenceID = 1
    var talks = [Talk]()
    
    // MARK: - View controller lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureDetailViewController()
    }
    
    // MARK: - Helpers
    
    func configureDetailViewController() {
        talks = DatabaseAccess.sharedDatabaseAccess.getTalksFromConference(conferenceID)
    }
    
}
