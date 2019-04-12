//
//  MessageCell.swift
//  Smack
//
//  Created by Christian Davis on 4/12/19.
//  Copyright © 2019 xianapps. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {

    // Outlets
    @IBOutlet weak var userImg: CircleImage! // STEP 180.
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var timeStampLbl: UILabel!
    @IBOutlet weak var messageBodyLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // Jonny says we're not using this
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }

    func configureCell(message: Message) {
        messageBodyLbl.text = message.message
        userNameLbl.text = message.userName
        userImg.image = UIImage(named: message.userAvatar)
        userImg.backgroundColor = UserDataService.instance.returnUIColor(components: message.userAvatarColor)
    }
}
