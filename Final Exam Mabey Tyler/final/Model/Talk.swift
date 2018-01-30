//
//  Talk.swift
//  final
//
//  Created by Tyler Mabey on 12/18/17.
//  Copyright © 2017 Tyler Mabey. All rights reserved.
//

import Foundation
import GRDB

struct Talk: TableMapping, RowConvertible {
    
    // MARK: - Properties
    
    var id: Int
    var title: String
    var descr: String
    
    // MARK: - Table mapping
    
    static let databaseTableName = "conference"
    
    // MARK: - Field names
    
    static let id = "ID"
    static let title = "Title"
    static let descr = "Description"
    
    // MARK: - Initialization
    
    init() {
        id = 0
        title = ""
        descr = ""
    }
    
    init(row: Row) {
        id = row[Talk.id]
        title = row[Talk.title]
        descr = row[Talk.descr]
    }
}
