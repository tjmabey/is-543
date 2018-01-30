//
//  TableViewController.swift
//  final
//
//  Created by Tyler Mabey on 12/18/17.
//  Copyright © 2017 Tyler Mabey. All rights reserved.
//

import UIKit

class GCTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    var lastUpdated = DatabaseAccess.sharedDatabaseAccess.lastUpdated()
    var conferences = DatabaseAccess.sharedDatabaseAccess.getAllConferences()
    
    private struct Storyboard {
        static let GCCell = "ConferenceCell"
        static let UpdatedCell = "UpdatedCell"
        static let ShowTalksSegue = "ShowTalks"
    }
    
    private struct Section {
        static let Updated = 0
        static let Conference = 1
    }

    // MARK: - View controller lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    // MARK: - Segues
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Storyboard.ShowTalksSegue {
            if let destVC = segue.destination as? TalksViewController {
                if let indexPath = tableView.indexPathForSelectedRow {
                    destVC.conferenceID = indexPath.row
                }
            }
        }
    }

    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == Section.Updated {
            let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.UpdatedCell, for: indexPath)
            cell.textLabel?.text = "This list was last updated: \(lastUpdated)"
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.GCCell, for: indexPath)
            
            cell.textLabel?.text = conferences[indexPath.row].1
            
            
            return cell
        }
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == Section.Updated {
            return 1
        }
        
        return conferences.count
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: Storyboard.ShowTalksSegue, sender: self)
    }
    
}

