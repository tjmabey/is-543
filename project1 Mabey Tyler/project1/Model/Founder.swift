//
//  Founder.swift
//  project1
//
//  Created by Tyler Mabey on 9/26/17.
//  Copyright © 2017 Tyler Mabey. All rights reserved.
//

import Foundation

class Founder {
    
    // MARK: - Properties
    var fName: String
    var lName: String
    var company: String
    var email: String
    var photo: String
    var phone: String
    var spouse: String?
    var profile: String
    var fullName: String
    
    // MARK: - Initializaion
    init(fName: String, lName: String, company: String, email: String, photo: String = "default", phone: String, profile: String, spouse: String = "") {
        self.fName = fName
        self.lName = lName
        self.company = company
        self.email = email
        self.photo = photo
        self.phone = phone
        self.profile = profile
        self.spouse = spouse
        self.fullName = "\(self.fName) \(self.lName)"
    }
    
}
