//
//  ChannelVC.swift
//  Smack
//
//  Created by Christian Davis on 2/18/19.
//  Copyright © 2019 xianapps. All rights reserved.
//

import UIKit

class ChannelVC: UIViewController {
    
    // STEP 8a. Outlets
    @IBOutlet weak var loginBtn: UIButton! // to change 'Login' button title to user's handle
    @IBOutlet weak var userImg: CircleImage! // STEP 81.
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue){ // STEP 14. Jonny adds this statement manually, unconnected. Perhaps this should be moved down with other IBAction?
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.revealViewController().rearViewRevealWidth = self.view.frame.size.width - 60 // STEP 5. experiement with different values here
        NotificationCenter.default.addObserver(self, selector: #selector(ChannelVC.userDataDidChange(_:)), name: NOTIF_USER_DATA_DID_CHANGE, object: nil) // STEP 79. Observer is listening for our notification triggered after successfully creating a user, when we hear it we call ChannelVC.userDataDidChange(_:). Was (observer: Any, selector: Selector, name: NSNotification.Name?, object: Any?) -- before filling in selector, Jonny defines func userDataDidChange() below
    }

    // Jonny deletes boilerplate code here
    @IBAction func loginBtnPressed(_ sender: Any) { // STEP 8b.
        performSegue(withIdentifier: TO_LOGIN, sender: nil) // STEP 10.
    }
    
    @objc func userDataDidChange(_ notif: Notification) { // STEP 80. Jonny adds @objc, don't know how he knows to...
        if AuthService.instance.isLoggedIn { // Updates user image and name once logged in
            loginBtn.setTitle(UserDataService.instance.name, for: .normal)
            userImg.image = UIImage(named: UserDataService.instance.avatarName) // STEP 82a.
            userImg.backgroundColor = UserDataService.instance.returnUIColor(components: UserDataService.instance.avatarColor) // STEP 85.
        } else { // STEP 82b.
            loginBtn.setTitle("Login", for: .normal) // set back to default image and name after logging out
            userImg.image = UIImage(named: "menuProfileIcon")
            userImg.backgroundColor = UIColor.clear
        }
    }
}
