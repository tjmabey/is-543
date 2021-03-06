//
//  TopicsViewController.swift
//  FoundingFathersEx
//
//  Created by Tyler Mabey on 9/19/17.
//  Copyright © 2017 Tyler Mabey. All rights reserved.
//

import UIKit

class TopicsViewController: UITableViewController {
    
    // MARK: - Constants
    
    private struct Storyboard {
        static let ShowQuoteSegueIdentifier = "ShowQuote"
        static let TopicCellIdentifier = "TopicCell"
    }
    // MARK: - Properties
    
    var selectedTopic: String?
    
    // MARK: - View controller lifecycle
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? QuoteViewController {
            destinationVC.topic = selectedTopic?.capitalized
        }
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.TopicCellIdentifier, for: indexPath)
        
        cell.textLabel?.text = QuoteDeck.sharedInstance.tagSet[indexPath.row].capitalized
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return QuoteDeck.sharedInstance.tagSet.count
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // needs work for segue to view controller and tell it to display quotes for selected topic
        selectedTopic = QuoteDeck.sharedInstance.tagSet[indexPath.row]
        performSegue(withIdentifier: Storyboard.ShowQuoteSegueIdentifier, sender: self)
    }
    
    
}
