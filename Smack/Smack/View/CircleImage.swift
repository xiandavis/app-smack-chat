//
//  CircleImage.swift
//  Smack
//
//  Created by Christian Davis on 3/31/19.
//  Copyright © 2019 xianapps. All rights reserved.
//

import UIKit

@IBDesignable // STEP 64. We don't need @IBInspectable as in RoundedButton.swift because not affecting SB
class CircleImage: UIImageView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override func awakeFromNib() { // STEP 65.
        setUpView()
    }
    
    func setUpView() {
        self.layer.cornerRadius = self.frame.width / 2 // perfect circle, assuming cell is square
        self.clipsToBounds = true
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setUpView()
    }
}
