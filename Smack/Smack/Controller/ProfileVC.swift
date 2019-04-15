//
//  ProfileVC.swift
//  Smack
//
//  Created by Christian Davis on 4/1/19.
//  Copyright © 2019 xianapps. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {
    
    // Outlets
    @IBOutlet weak var profileImg: UIImageView! // STEP 86.
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var bgView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
//        MY ATTEMPT AT FILLING PROFILEVC WITH INFO FAILED. See setUpView() below for solution
//        profileImg.image = UIImage(named: UserDataService.instance.avatarName)
//        userName. = UserDataService.instance.name
//        userEmail.text = UserDataService.instance.email

        // Do any additional setup after loading the view.
    }

    // Jonny deletes boilerplate code
    @IBAction func closeModalPressed(_ sender: Any) { // STEP 90. Referred to LoginVC for this. Works without self. - not sure why Jonny includes
        /*self.*/ dismiss(animated: true, completion: nil)
    }
    @IBAction func logoutPressed(_ sender: Any) { // STEP 92.
        UserDataService.instance.logoutUser()
        NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
        dismiss(animated: true, completion: nil)
    }
    
    func setUpView() { // STEP 89.
        userName.text = UserDataService.instance.name
        userEmail.text = UserDataService.instance.email
        profileImg.image = UIImage(named: UserDataService.instance.avatarName)
        profileImg.backgroundColor = UserDataService.instance.returnUIColor(components: UserDataService.instance.avatarColor)
        
        let closeTouch = UITapGestureRecognizer(target: self, action: #selector(ProfileVC.closeTap(_:))) // STEP 93. CREATE GestureRecognizer. Jonny leaves as (target: Any?, action: Selector?), in order to define closeTap() below for use as above's Selector?
        bgView.addGestureRecognizer(closeTouch) // STEP 95. ADD GestureRecognizer - must ADD in order to work!
    }
    
    @objc func closeTap(_ recognizer: UITapGestureRecognizer) { // STEP 94.
        dismiss(animated: true, completion: nil)
    }
}
