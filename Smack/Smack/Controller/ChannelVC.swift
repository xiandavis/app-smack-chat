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
    
    override func viewDidAppear(_ animated: Bool) { // STEP 108. Jonny notes that ChannelVC [this View] may not have been instantiated when our NOTIF_USER_DATA_DID_CHANGE notification fired off, so we need to do a check and setup the user data accordingly using func setUpUserInfo(), ~24 line numbers down
        setUpUserInfo() // STEP 114.
    }

    // Jonny deletes boilerplate code here
    @IBAction func loginBtnPressed(_ sender: Any) { // STEP 8b.
        if AuthService.instance.isLoggedIn { // STEP 87.
            // Show profile page (no segue like in SB, so must present manually)
            let profile = ProfileVC() // instantiate it
            profile.modalPresentationStyle = .custom // set modal presentation style
            present(profile, animated: true, completion: nil) // present it. Was (viewControllerToPresent: UIViewController, animated: Bool, completion: (() -> Void)?)
        } else {
            performSegue(withIdentifier: TO_LOGIN, sender: nil) // STEP 10. Statement created STEP 88. Statement moved inside if/else
        }
    }
    
    @objc func userDataDidChange(_ notif: Notification) { // STEP 80. Jonny adds @objc, don't know how he knows to...
        setUpUserInfo() // STEP 113.
    }
    
    func setUpUserInfo() { // STEP 109.
        if AuthService.instance.isLoggedIn { // Updates user image and name once logged in
            loginBtn.setTitle(UserDataService.instance.name, for: .normal)
            userImg.image = UIImage(named: UserDataService.instance.avatarName) // STEP 82a. CREATED statement in userDataDidChange() above, STEP 110. MOVED statement here
            userImg.backgroundColor = UserDataService.instance.returnUIColor(components: UserDataService.instance.avatarColor) // STEP 85. CREATED statement in userDataDidChange() above, STEP 111. MOVED statement here
        } else { // STEP 82b. CREATED statement in userDataDidChange() above, STEP 112. MOVED statement here
            loginBtn.setTitle("Login", for: .normal) // set back to default image and name after logging out
            userImg.image = UIImage(named: "menuProfileIcon")
            userImg.backgroundColor = UIColor.clear
        }
    }
}
