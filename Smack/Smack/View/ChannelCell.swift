//
//  ChannelCell.swift
//  Smack
//
//  Created by Christian Davis on 4/3/19.
//  Copyright © 2019 xianapps. All rights reserved.
//

import UIKit

class ChannelCell: UITableViewCell {
    
    // Outlets
    @IBOutlet weak var channelName: UILabel! // STEP 124.
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        if selected { // STEP 125. What does the view look like for a row in the table view that is selected?
            self.layer.backgroundColor = UIColor(white: 1, alpha: 0.2).cgColor
        } else {
            self.layer.backgroundColor = UIColor.clear.cgColor
        }
    }
    
    func configureCell(channel : Channel) {
        let title = channel.name ??  "" // ?? = no coalescing operator: if you can't find a value there, then return an empty string. Jonny using channelTitle instead of name
        channelName.text = "#\(title)"
    }
}
