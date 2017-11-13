//
//  TempleView.swift
//  project2
//
//  Created by Tyler Mabey on 10/18/17.
//  Copyright © 2017 Tyler Mabey. All rights reserved.
//

import UIKit

@IBDesignable
class TempleView : UIView {
    
    
    // MARK: - Properties
    
    var temple = Temple(filename: "los-angeles-temple-766339-wallpaper.jpg", name: "Los Angeles California")
    @IBInspectable var isStudyMode: Bool = true
    
    var imageMargin: CGFloat { return bounds.width * 0.15 }
    
    // MARK: - Computed properties
    
    var cornerRadius: CGFloat { return bounds.width * 0.05}
    
    @IBInspectable var name: String {
        get {
            return temple.name
        }
        set {
            temple.name = newValue
        }
    }
    
    @IBInspectable var fileName: String {
        get {
            return temple.filename
        }
        set {
            temple.filename = newValue
        }
    }
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override func prepareForInterfaceBuilder() {
        setup()
    }
    
    private func setup() {
        backgroundColor = UIColor.clear
        isOpaque = false
    }
    
    // MARK: - Drawing
    
    override func draw(_ rect: CGRect) {
        drawBase()
        drawTempleImage()
        if isStudyMode {
            drawLabel()
        }

        
    }
    
    
    private func drawBase() {
        let roundedRect = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        
        roundedRect.addClip()
        UIColor.white.setFill()
        UIRectFill(bounds)
    }
    
    private func drawLabel() {
        guard let font = UIFont(name: "Helvetica", size: 12.0) else {
            return
        }
        
        let labelText = NSAttributedString(string: " \(temple.name) ", attributes: [
            .font: font,
            .foregroundColor: UIColor.white,
            .backgroundColor: UIColor.black.withAlphaComponent(0.8)
            ])
        
        labelText.draw(at: CGPoint(x: bounds.width * 0.03, y: bounds.height * 0.84))
        
    }
    
    private func drawTempleImage() {
        guard let templeImage = UIImage(named: temple.filename) else {
            return
        }

        templeImage.draw(in: bounds)
    }
    
}
