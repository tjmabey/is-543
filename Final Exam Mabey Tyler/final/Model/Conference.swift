//
//  Conference.swift
//  final
//
//  Created by Tyler Mabey on 12/18/17.
//  Copyright © 2017 Tyler Mabey. All rights reserved.
//

import Foundation
import GRDB

struct Conference: TableMapping, RowConvertible {
    
    // MARK: - Properties
    
    var id: Int
    var abbr: String
    
    // MARK: - Table mapping
    
    static let databaseTableName = "conference"
    
    // MARK: - Field names
    
    static let id = "ID"
    static let abbr = "Abbr"
    
    // MARK: - Initialization
    
    init() {
        id = 0
        abbr = ""
    }
    
    init(row: Row) {
        id = row[Conference.id]
        abbr = row[Conference.abbr]
    }
}
