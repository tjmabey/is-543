//
//  FounderListController.swift
//  project1
//
//  Created by Tyler Mabey on 9/26/17.
//  Copyright © 2017 Tyler Mabey. All rights reserved.
//

import UIKit

class FounderListController: UITableViewController {
    
    // MARK: - Constants
    
    private struct Storyboard {
        static let FounderCellIdentifier = "FounderCell"
        static let ShowProfileSegueIdentifier = "ShowProfile"
    }
    
    // MARK: - Properties
    
    var selectedProfile: Founder?
    var selectedIndex = 0
    
    // MARK: - View controller lifecycle
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? ProfileViewController
        {
            guard let unwrappedFounder = selectedProfile else { return }
            destinationVC.updateUI(with: unwrappedFounder)
            
        }
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.FounderCellIdentifier, for: indexPath)
        
        cell.textLabel?.text = "\(FounderList.sharedInstance.founderSet[indexPath.row].fName) \(FounderList.sharedInstance.founderSet[indexPath.row].lName)"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FounderList.sharedInstance.founderSet.count
    }
    
    // MARK: - Table view data delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedProfile = FounderList.sharedInstance.founderSet[indexPath.row]
        selectedIndex = indexPath.row
        performSegue(withIdentifier: "ShowProfile", sender: self)
    }
}

