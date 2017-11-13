//
//  GameViewController.swift
//  project2
//
//  Created by Tyler Mabey on 10/17/17.
//  Copyright © 2017 Tyler Mabey. All rights reserved.
//

import UIKit

class GameViewController : UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var templeList: UITableView!
    @IBOutlet weak var resetOutlet: UIBarButtonItem!
    @IBOutlet weak var modeButton: UIBarButtonItem!
    @IBOutlet weak var templeCollectionView: UICollectionView!
    @IBOutlet weak var templeListTableView: UITableView!
    @IBOutlet weak var scorelabel: UILabel!
    @IBOutlet weak var correctlabel: UILabel!
    @IBOutlet weak var tableViewWidth: NSLayoutConstraint!
    
    // MARK: - Actions
    
    @IBAction func switchMode(_ sender: UIBarButtonItem) {
        game.isStudyMode = !game.isStudyMode
        game.reset()
        if game.isStudyMode {
            game.shuffledTemplesForCollectionView = game.allTemplesAlphabetical
            // hide the table view
            view.layoutIfNeeded()
            UITableView.animate(withDuration: 0.25, animations: {
                
                self.tableViewWidth.constant = (-1.0)
                self.view.layoutIfNeeded()
            }, completion: { finished in if finished {
                    self.templeCollectionView.reloadData()
                    }
                })
            
        } else {
            // show the table view
            view.layoutIfNeeded()
            UITableView.animate(withDuration: 0.25, animations: {
                self.tableViewWidth.constant = ViewConstants.tableViewWidth
                self.view.layoutIfNeeded()
            }, completion: { finished in if finished {
                    self.templeCollectionView.reloadData()
                    }
                })
        }
        
        updateUI()
    }
    
    @IBAction func resetAction(_ sender: UIBarButtonItem) {
        game.reset()
        updateUI()
    }
    
    // MARK: - Constants
    
    private struct Storyboard {
        static let CellIdentifier = "TempleCell"
        static let ImageIdentifier = "ImageCell"
    }
    
    private struct ViewConstants {
        static let FixedHeight = CGFloat(100.0)
        static let timer = 10
        static let normalAlpha = CGFloat(1.0)
        static let selectedAlpha = CGFloat(0.45)
        static let tableViewWidth = CGFloat(200.0)
    }
    
    // MARK: - Properties
    
    var game = TempleGame()
    var selectedTableIndex = IndexPath(row: 0, section: 0)
    var selectedImageIndex = IndexPath(row: 0, section: 0)
    var isTempleSelected = false
    var isImageSelected = false
    
    // MARK: - View controller lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    // MARK: - Helpers
    
    private func updateUI() {
        if game.isStudyMode {
            // study mode
            modeButton.title = "Game"
            resetOutlet.isEnabled = false
            scorelabel.text = ""
            correctlabel.text = ""
        } else {
            // game mode
            modeButton.title = "Study"
            resetOutlet.isEnabled = true
            if game.correct + game.incorrect > 0 {
                scorelabel.text = "Correct: \(game.correct)/\(game.correct + game.incorrect)"
            } else {
                scorelabel.text = ""
                correctlabel.text = ""
            }
        }
        templeListTableView.reloadData()
        templeCollectionView.reloadData()
    }
    
    private func checkMatch() {
        if isImageSelected && isTempleSelected {
            isImageSelected = false
            isTempleSelected = false
            if game.shuffledTemplesForTableView[selectedTableIndex.row].name ==
                game.shuffledTemplesForCollectionView[selectedImageIndex.row].name {
                 // correct match
                game.correct += 1
                
                correctlabel.textColor = .green
                correctlabel.text = "Correct"
                
                // update collection view model
                game.shuffledTemplesForCollectionView.remove(at: selectedImageIndex.row)
                
                // update table view model
                game.shuffledTemplesForTableView.remove(at: selectedTableIndex.row)
                
                // update collection view
                templeCollectionView.deleteItems(at: [selectedImageIndex])
                
                // update table view
                templeListTableView.beginUpdates()
                templeListTableView.deleteRows(at: [selectedTableIndex], with: .automatic)
                templeListTableView.endUpdates()
            } else {
                // incorrect match
                game.incorrect += 1
                correctlabel.textColor = .red
                correctlabel.text = "Incorrect"
            }
            scorelabel.text = "Correct: \(game.correct)/\(game.correct + game.incorrect)"
            DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
                self.correctlabel.text = ""
            }
        }
    }

    
}

extension GameViewController : UITableViewDataSource {
    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.CellIdentifier, for: indexPath)
        
        cell.textLabel?.text = game.shuffledTemplesForTableView[indexPath.row].name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return game.shuffledTemplesForTableView.count
    }
}

extension GameViewController : UITableViewDelegate {
    // MARK: - Table view delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedTableIndex = indexPath
        isTempleSelected = true
        checkMatch()
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        checkMatch()
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}

extension GameViewController : UICollectionViewDataSource {
    // MARK: - Collection view data source
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return game.shuffledTemplesForCollectionView.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Storyboard.ImageIdentifier, for: indexPath)
        
        if let templeCell = cell as? TempleImageCell {
            templeCell.templeView.temple = game.shuffledTemplesForCollectionView[indexPath.row]
            templeCell.templeView.isStudyMode = game.isStudyMode
            templeCell.templeView.layer.borderWidth = 4
            templeCell.templeView.layer.borderColor = UIColor.white.cgColor
            
            if game.isStudyMode {
                templeCell.isUserInteractionEnabled = false
            } else {
                templeCell.isUserInteractionEnabled = true
            }
            templeCell.templeView.setNeedsDisplay()
        }
        
        return cell
    }
    
}

extension GameViewController : UICollectionViewDelegate {
    // MARK: - Collection view data delegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let templeCell = collectionView.cellForItem(at: indexPath) as? TempleImageCell {
            isImageSelected = true
            selectedImageIndex = indexPath
            
            checkMatch()
            templeCell.alpha = ViewConstants.selectedAlpha
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let templeCell = collectionView.cellForItem(at: indexPath) as? TempleImageCell {
            templeCell.alpha = ViewConstants.normalAlpha
        }
    }
    
}

extension GameViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if let i = UIImage(named: game.shuffledTemplesForCollectionView[indexPath.row].filename){
            let size = i.size
            let fixedHeight = ViewConstants.FixedHeight
            let aspect = size.width / size.height
            let computedWidth = aspect * fixedHeight
            
            return CGSize(width: computedWidth, height: fixedHeight)
        }
        // default
        return CGSize(width: 100, height: 100)
    }
}
