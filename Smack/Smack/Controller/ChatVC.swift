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
        
        if AuthService.instance.isLoggedIn { // STEP 107. Jonny notes than when we exit app, it still thinks we are logged in but doesn’t show all user info
            AuthService.instance.findUserByEmail(completion: { (success) in
                NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
            })
        }
        
    }
    
    // Jonny deletes boilerplate code here
    
    
    
}
