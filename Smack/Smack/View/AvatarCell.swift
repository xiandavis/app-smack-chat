//
//  AvatarCell.swift
//  Smack
//
//  Created by Christian Davis on 3/30/19.
//  Copyright © 2019 xianapps. All rights reserved.
//

import UIKit

class AvatarCell: UICollectionViewCell { // STEP 53.
    
    @IBOutlet weak var avatarImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib() // Jonny knows to include this line from clicking awakeFromNib and looking to right at Quick Help in Utilites panel (second paragraph)
        setUpView()
    }
    
    func setUpView() {
        self.layer.backgroundColor = UIColor.lightGray.cgColor
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
    }
    
}
