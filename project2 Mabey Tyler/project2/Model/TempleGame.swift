//
//  User.swift
//  project2
//
//  Created by Tyler Mabey on 10/17/17.
//  Copyright © 2017 Tyler Mabey. All rights reserved.
//

import Foundation

class TempleGame {
    
    // MARK: - Properties
    
    var correct = 0
    var incorrect = 0
    var isStudyMode = false
    var allTemplesAlphabetical: [Temple] = []
    var shuffledTemplesForTableView: [Temple] = []
    var shuffledTemplesForCollectionView: [Temple] = []
    
    // MARK: - Initialization
    
    init() {
        reset()
    }
    
    // MARK: - Helpers
    
    func reset() {
        correct = 0
        incorrect = 0
        allTemplesAlphabetical = TempleDeck.allTemplesAlphabetical
        shuffledTemplesForTableView = TempleDeck.shuffle()
        shuffledTemplesForCollectionView = TempleDeck.shuffle()
    }
}
