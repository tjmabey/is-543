//
//  VolumesViewController.swift
//  Map Scriptures
//
//  Created by Tyler Mabey on 11/7/17.
//  Copyright © 2017 Tyler Mabey. All rights reserved.
//

import UIKit

class VolumesViewController : UITableViewController {
    
    var volumes = GeoDatabase.sharedGeoDatabase.volumes()
    
    private struct Storyboard {
        static let VolumeCell = "VolumeCell"
        static let ShowBooksSegue = "Show Books"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Storyboard.ShowBooksSegue {
            if let destVC = segue.destination as? BooksViewController {
                if let indexPath = tableView.indexPathForSelectedRow {
                    destVC.books = GeoDatabase.sharedGeoDatabase.booksForParentId(indexPath.row + 1)
                    destVC.title = volumes[indexPath.row]
                }
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.VolumeCell, for: indexPath)
        
        cell.textLabel?.text = volumes[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return volumes.count
    }
}
