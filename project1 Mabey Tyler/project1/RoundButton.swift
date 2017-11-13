//
//  RoundButton.swift
//  project1
//
//  Created by Tyler Mabey on 9/30/17.
//  Copyright © 2017 Tyler Mabey. All rights reserved.
//
import UIKit

@IBDesignable class MyButton: UIButton
{
    override func layoutSubviews() {
        super.layoutSubviews()
        
        updateCornerRadius()
    }
    
    @IBInspectable var rounded: Bool = false {
        didSet {
            updateCornerRadius()
        }
    }
    
    func updateCornerRadius() {
        layer.cornerRadius = rounded ? frame.size.height / 2 : 0
    }
}
