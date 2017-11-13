//
//  BooksViewController.swift
//  Map Scriptures
//
//  Created by Tyler Mabey on 11/7/17.
//  Copyright © 2017 Tyler Mabey. All rights reserved.
//

import UIKit

class BooksViewController : UITableViewController {
    
    // MARK: - Properties
    var books: [Book]!
    
    private struct Storyboard {
        static let BookCell = "BookCell"
        static let ShowScriptureSegue = "Show Scripture"
    }
    
    // MARK: - Segues
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Storyboard.ShowScriptureSegue {
            if let destVC = segue.destination as? ScriptureViewController {
                if let indexPath = tableView.indexPathForSelectedRow {
                    destVC.book = books[indexPath.row]
                    destVC.chapter = 2
                    destVC.title = "\(books[indexPath.row].fullName) 2"
                }
                
                
            }
        }
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.BookCell, for: indexPath)
        
        cell.textLabel?.text = books[indexPath.row].fullName
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: Storyboard.ShowScriptureSegue, sender: self)
    }
}
