//
//  FounderList.swift
//  project1
//
//  Created by Tyler Mabey on 9/26/17.
//  Copyright © 2017 Tyler Mabey. All rights reserved.
//

import Foundation

class FounderList {
    
    // MARK: - Properties
    
    var founderSet: [Founder] = []
    
    let founders = [
        Founder(fName: "Bobby", lName: "Jones", company: "ABC corp", email: "bobby@gmail.com", photo: "bob", phone: "8015678910", profile: "Bobby is the founder of ABC corp. He likes to build."),
        Founder(fName: "Han", lName: "Solo", company: "Galactic trade", email: "han@gmail.com", photo: "hansolo", phone: "8018811881", profile: "Han Solo is an accomplished trader and has saved the universe on multiple occcasions.", spouse: "Leia" ),
        Founder(fName: "Tim", lName: "Cook", company: "Apple", email: "tim@gmail.com", photo: "timcook", phone: "8015008910", profile: "Tim is the CEO of Apple and likes to sell iPhones."),
        Founder(fName: "Jimmy", lName: "John", company: "Jimmy Johns", email: "jim@gmail.com", photo: "jimmyjohn", phone: "8017508910", profile: "Jimmy founded his own sandwich restaurant and has opened more than 200 franchise locations."),
        Founder(fName: "Luke", lName: "Skywalker", company: "Rebel alliance", email: "luke@rebelmail.com", phone: "6022549821", profile: "Luke is a farmer originally from the Tatooine system. After his farming career, Luke went on to becoming a jedi master, crafting his own lightsaber and learning the force.")
    ]
    
    // MARK: - Singleton pattern
    
    static let sharedInstance = FounderList()
    
    private init() {
        update()
    }
    
    // MARK: - Private helpers
    
    private func update() {
        founderSet = []
        
        for founder in founders {
            founderSet.append(founder)
        }
        
        founderSet = founderSet.sorted(by: { ($0.lName < $1.lName) })
    }
}
