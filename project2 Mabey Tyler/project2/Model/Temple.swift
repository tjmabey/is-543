//
//  Temple.swift
//  project2
//
//  Created by Tyler Mabey on 10/17/17.
//  Copyright © 2017 Tyler Mabey. All rights reserved.
//

import Foundation

class Temple {
    var name = ""
    var filename = ""
    
    init() {
        // default initializer
    }
    
    init(filename: String, name: String) {
        self.filename = filename
        self.name = name
    }
}
