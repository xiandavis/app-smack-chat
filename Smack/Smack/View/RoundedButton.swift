//
//  RoundedButton.swift
//  Smack
//
//  Created by Christian Davis on 3/26/19.
//  Copyright © 2019 xianapps. All rights reserved.
//

import UIKit

@IBDesignable // STEP 27a.
class RoundedButton: UIButton {

    // Jonny deletes boilerplate code here
    @IBInspectable var cornerRadius: CGFloat = 3.0 { // Jonny says needed to affect button appearance in the SB / IB
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    override func awakeFromNib() { // Jonny gets autocompletion to bring this statement up by typing 'awakeFromNib'
        self.setUpView() // not defined yet! See below
    }
    
    override func prepareForInterfaceBuilder() { // STEP 28.
        super.prepareForInterfaceBuilder()
        self.setUpView()
    }
    
    func setUpView() {
        self.layer.cornerRadius = cornerRadius // STEP 27b.
    }

}
