//
//  AvatarCell.swift
//  Smack
//
//  Created by Christian Davis on 3/30/19.
//  Copyright © 2019 xianapps. All rights reserved.
//

import UIKit

enum AvatarType { // STEP 55.
    case dark
    case light
}

class AvatarCell: UICollectionViewCell { // STEP 53a.
    
    @IBOutlet weak var avatarImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib() // Jonny knows to include this line from clicking awakeFromNib and looking to right at Quick Help in Utilites panel (second paragraph)
        setUpView()
    }
    
    func configureCell(index: Int, type: AvatarType) { // STEP 56. index so we can set the image, type so we can set dark/ light
        if type == AvatarType.dark {
            avatarImg.image = UIImage(named: "dark\(index)")
            self.layer.backgroundColor = UIColor.lightGray.cgColor // contrasting lighter bg
        } else {
            avatarImg.image = UIImage(named: "light\(index)")
            self.layer.backgroundColor = UIColor.gray.cgColor // contrasting darker bg
        }
    }
    
    func setUpView() { // STEP 53b.
        self.layer.backgroundColor = UIColor.lightGray.cgColor
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
    }
    
}
