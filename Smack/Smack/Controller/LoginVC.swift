//
//  LoginVC.swift
//  Smack
//
//  Created by Christian Davis on 2/27/19.
//  Copyright © 2019 xianapps. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    
    // Outlets
    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView() // STEP 105. must call it!
    }

    // Jonny deletes didReceiveMemoryWarning() and other boilerplate code here
    
    @IBAction func closePressed(_ sender: Any) { // STEP 11. ⌃dragged closeBtn from SB to here, set as IBAction
        dismiss(animated: true, completion: nil)
    }
    @IBAction func createAccntBtnPressed(_ sender: Any) { // STEP 13.
        performSegue(withIdentifier: TO_CREATE_ACCOUNT, sender: nil)
    }
    @IBAction func loginPressed(_ sender: Any) {
        spinner.isHidden = false // STEP 106.
        spinner.startAnimating()
        
        guard let email = usernameTxt.text , usernameTxt.text != "" else { return } // Jonny originally used userName instead of email in this statement, but realized he named vars poorly. Perhaps we will change placeholder on login screen to read email instead of username?
        guard let pass = passwordTxt.text , passwordTxt.text != "" else { return }
        
        AuthService.instance.loginUser(email: email, password: pass) { (success) in
            if success {
                AuthService.instance.findUserByEmail(completion: { (success) in
                    if success {
                        NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
                        self.spinner.isHidden = true
                        self.spinner.stopAnimating()
                        self.dismiss(animated: true, completion: nil)
                    }
                })
            }
        }
        
    }
    
    func setUpView() { // STEP 104. Jonny copies name & email from same func inside CreateAccountVC, replaces latter with password. Perhaps instead of usernameTxt should be emailTxt and change placeholder on Login screen?
        spinner.isHidden = true
        usernameTxt.attributedPlaceholder = NSAttributedString(string: "username", attributes: [NSAttributedStringKey.foregroundColor: smackPurplePlaceholder]) // STEP 69. color of placeholder text cannot be changed from IB directly
        passwordTxt.attributedPlaceholder = NSAttributedString(string: "password", attributes: [NSAttributedStringKey.foregroundColor: smackPurplePlaceholder]) // STEP 71. color of placeholder text cannot be changed from IB directly
    }
    
}
