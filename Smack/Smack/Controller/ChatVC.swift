//
//  ChatVC.swift
//  Smack
//
//  Created by Christian Davis on 2/18/19.
//  Copyright © 2019 xianapps. All rights reserved.
//

import UIKit

class ChatVC: UIViewController {
    
    // Outlets - Jonny finds ^dragging from DO to here more accurate than ^dragging from the button in SB to here
    @IBOutlet weak var menuBtn: UIButton! // STEP 2. Jonny understands it may seem strange to have a button be an outlet rather than an action, but he says we will manually implement the action associated with the button inside viewDidLoad() below
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside) // STEP 3. The param Target is self.revealViewController(), param Selector is a objC method we are going to invoke (the method specifically being revealToggle()--Jonny ⌘clicks revealToggle() to Jump to Definition to read comments above it describing how to use it), param UIControlEvents is .touchUpInside
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer()) // STEP 4. gestureRecognizer: UIGestureRecognizer is self.revealViewController().panGestureRecognizer(), panGestureRecognizer is for slide motion
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer()) // same as above, tapGestureRecognizer is for tap motion
        
        if AuthService.instance.isLoggedIn { // STEP 107. Jonny notes than when we send app to background and re-enter, a boolean variable saying if we are still logged in or not is set to true, but the app no longer shows all user info. To solve we need to check if we are Logged in; if so, we call Find User By Email and do our post notification that user data changed.
            AuthService.instance.findUserByEmail(completion: { (success) in
                NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
            })
        }
        MessageService.instance.findAllChannel { (success) in // STEP 123. Jonny just testing JSON parsing in Swift 4 to display channel properties in console. This threw error because there were no channels created yet - solution by student Jemimah 'Share: How to solve error when your api url for your channels displays as "Unauthorized" and/or channels do not display during runtime' is as follows: in Postman app, register/login/add a user. Copy user auth token in response and paste in Add Channel's header on line KEY Authentication for VALUE after 'Bearer ', hit send to create default channel. Then run Smack app (this is all while mac-chat-api/node.js [npm run dev] is running in Terminal in tab #1 and local db/mongodb [--dbpath /Users/xianAir/mac-chat-api/data/db/ --port 27017] is running in tab #2)
        }
    }
    
    // Jonny deletes boilerplate code here
    
    
    
}
