//
//  GradientView.swift
//  Smack
//
//  Created by Christian Davis on 2/20/19.
//  Copyright © 2019 xianapps. All rights reserved.
//

import UIKit

@IBDesignable // STEP 6. Let's this class know that it needs to render inside the storyboard (SB) / interface builder (IB). See Mark's use of this statement in S4:L51
class GradientView: UIView {

    // Jonny deletes boilerplate code here
    
    @IBInspectable var topColor: UIColor = #colorLiteral(red: 0.2901960784, green: 0.3019607843, blue: 0.8470588235, alpha: 1) { // STEP 7. (color literal portion only). Clicked Other... button in popup window > Color Sliders > RGB Sliders, entered Hex Color #. IBInspectable change inside SB dynamically
        didSet {
            self.setNeedsLayout()
        }
    }
    
    @IBInspectable var bottomColor: UIColor = #colorLiteral(red: 0.1725490196, green: 0.831372549, blue: 0.8470588235, alpha: 1) {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    override func layoutSubviews() { // called whenever we change one of the IBInspectable variables above
        let gradientLayer = CAGradientLayer() // create a layer, CA means Core Animation
        gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor] // set layer colors
        gradientLayer.startPoint = CGPoint(x: 0, y: 0) // startPoint of gradient
        gradientLayer.endPoint = CGPoint(x: 1, y: 1) // endPoint of gradient
        gradientLayer.frame = self.bounds // boundaries of gradient
        self.layer.insertSublayer(gradientLayer, at: 0) // insert subview into UIView itself
    }
}
