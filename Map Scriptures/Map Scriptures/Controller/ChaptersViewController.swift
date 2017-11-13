//
//  ChaptersViewController.swift
//  Map Scriptures
//
//  Created by Tyler Mabey on 11/12/17.
//  Copyright © 2017 Tyler Mabey. All rights reserved.
//

import UIKit

class ChaptersViewController : UITableViewController {
    
    // MARK: - Properties
    var book: Book!
    
    private struct Storyboard {
        static let ChapterCell = "ChapterCell"
        static let ShowChaptersSegue = "Show Chapters"
        static let ShowScriptureSegue = "Show Chapter Scriptures"
    }
    
    // MARK: - Segues
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Storyboard.ShowScriptureSegue {
            if let destVC = segue.destination as? ScriptureViewController {
                if let indexPath = tableView.indexPathForSelectedRow {
                    destVC.book = book
                    destVC.chapter = indexPath.row + 1
                    destVC.title = "\(book.fullName) \(indexPath.row + 1)"
                }
            }
        }
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.ChapterCell, for: indexPath)
        
        cell.textLabel?.text = "\(book.fullName) \(indexPath.row + 1)"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return book.numChapters!
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: Storyboard.ShowScriptureSegue, sender: self)
    }
    
}
