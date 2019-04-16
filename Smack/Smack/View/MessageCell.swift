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
        
        // STEP 213. ISO date format: 2017-07-13T21:49:25.590Z - .590Z is milliseconds, Apple does not play well with that portion. Jonny sends a final chat message on Jul 21, 1:53 AM while recording the timeStamp lecture (PST, Oregon).
        
        guard var isoDate = message.timeStamp else { return } // Unwrap String! timeStamp. Jonny received error until he changed this let to a var
        let end = isoDate.index(isoDate.endIndex, offsetBy: -5) // endIndex starts from the right end of the String, -5 chops off ms, end == what was originally 6 chars from right end
        // isoDate = isoDate.substring(to: end) -- Jonny's statement is depracated, my attempt below
        isoDate = String(isoDate[..<end]) // isoDate String contents now compatible with Apple built-in date format (the required Z suffix will be added below)
        
        let isoFormatter = ISO8601DateFormatter()
        let appleDate = isoFormatter.date(from: isoDate.appending("Z")) // appleDate is a Date obj created from the isoDate String and is a date compatible with Apple built-in format. would convert above date into 2017-07-13T21:49:25Z (no ms). opted to name constant chatDate 'appleDate' instead, and constant finalDate 'chatDate' instead, for clarity
        
        let newFormatter = DateFormatter()
        newFormatter.dateFormat = "MMM d, h:mm a" // specifies custom, more readable date formatter for user. MMM abbreviated month, d day, h hour, mm minutes, a AM/PM
        
        if let chatDateStr = appleDate { // safely unwraps optional (class ISO8601DateFormatter() uses optional)
            let chatDateStr = newFormatter.string(from: chatDateStr) // timeStampLbl.text requires we convert Date obj back to String
            timeStampLbl.text = chatDateStr
        }
    }
}
