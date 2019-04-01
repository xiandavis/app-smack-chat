//
//  CreateAccountVC.swift
//  Smack
//
//  Created by Christian Davis on 2/28/19.
//  Copyright © 2019 xianapps. All rights reserved.
//

import UIKit

class CreateAccountVC: UIViewController {
    
    // Outlets
    @IBOutlet weak var usernameTxt: UITextField! // STEP 25.
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passTxt: UITextField!
    @IBOutlet weak var userImg: UIImageView!
    @IBOutlet weak var spinner: UIActivityIndicatorView! // STEP 72.
    
    // Variables
    var avatarName = "profileDefault" // STEP 44.
    var avatarColor = "[0.5, 0.5, 0.5, 1]" // string array, contains RGB & alpha properties of a color (presently a light gray)
    var bgColor : UIColor? // STEP 61. Keeps track of whether value has been assigned or not
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView() // STEP 70.
    }
    
    override func viewDidAppear(_ animated: Bool) { // STEP 60. display selected avatar to account, default should already be an empty string
        if UserDataService.instance.avatarName != "" {
            userImg.image = UIImage(named: UserDataService.instance.avatarName)
            avatarName = UserDataService.instance.avatarName
            if avatarName.contains("light") && bgColor == nil { // STEP 63. Light and first time selecting avatar
                userImg.backgroundColor = UIColor.lightGray
            }
        }
    }

    // Jonny deletes boilerplate code
    @IBAction func pickAvatarPressed(_ sender: Any) { // STEP 48.
        performSegue(withIdentifier: TO_AVATAR_PICKER, sender: nil)
    }
    @IBAction func pickBGColorPressed(_ sender: Any) {
        let r = CGFloat(arc4random_uniform(255)) / 255 // STEP 62.
        let g = CGFloat(arc4random_uniform(255)) / 255
        let b = CGFloat(arc4random_uniform(255)) / 255
        
        bgColor = UIColor(red: r, green: g, blue: b, alpha: 1) // CGFloats, 1 means no transparency
        UIView.animate(withDuration: 0.2) { // STEP 66. Was withDuration: TimeInterval, animations: ()  -> Void, Jonny deleted what he didn't need
            self.userImg.backgroundColor = self.bgColor // self.[bgColor] because inside inclosure
        }
    }
    @IBAction func createAccntPressed(_ sender: Any) {
        spinner.isHidden = false // STEP 74.
        spinner.startAnimating()
        guard let name = usernameTxt.text , usernameTxt.text != "" else { return } // STEP 45.
        
        guard let email = emailTxt.text , emailTxt.text != "" else { return } // STEP 26. Jonny says the , reads 'if' or 'where' and is another way of unwrapping an optional value
        guard let pass = passTxt.text , passTxt.text != "" else { return }
        
        AuthService.instance.registerUser(email: email, password: pass) { (success) in // COMPLETION HANDLER / EDITOR PLACEHOLDER INSTRUCTIONS: hit return at the editor placeholder that now reads 'success' above, rename to success
            // a second editor placeholder was here, tab to it then delete and type below statements
            if success {
                // print("registered user!")
                AuthService.instance.loginUser(email: email, password: pass, completion: { (success) in // STEP 37.
                    if success {
                        // print("logged in user!", AuthService.instance.authToken)
                        AuthService.instance.createUser(name: name, email: email, avatarName: self.avatarName, avatarColor: self.avatarColor, completion: { (success) in // STEP 46. had to add self because inside a Closure
                            if success {
                                // print(UserDataService.instance.name, UserDataService.instance.avatarName)
                                self.spinner.isHidden = true // STEP 75. Need self
                                self.spinner.stopAnimating() // because inside a closure
                                self.performSegue(withIdentifier: UNWIND, sender: nil)
                                NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil) // STEP 78. The next lesson, S6:L78, will make use of this
                            }
                        })
                    }
                })
            }
        }
    }
    
    @IBAction func closePressed(_ sender: Any) { // STEP 16.
        performSegue(withIdentifier: UNWIND, sender: nil)
    }
    
    func setUpView() { // STEP 67. Jonny jumps to Constants.swift
        spinner.isHidden = true // STEP 73.
        usernameTxt.attributedPlaceholder = NSAttributedString(string: "username", attributes: [NSAttributedStringKey.foregroundColor: smackPurplePlaceholder]) // STEP 69. color of placeholder text cannot be changed from IB directly
        emailTxt.attributedPlaceholder = NSAttributedString(string: "email", attributes: [NSAttributedStringKey.foregroundColor: smackPurplePlaceholder]) // STEP 71. color of placeholder text cannot be changed from IB directly
        passTxt.attributedPlaceholder = NSAttributedString(string: "password", attributes: [NSAttributedStringKey.foregroundColor: smackPurplePlaceholder]) // color of placeholder text cannot be changed from IB directly
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(CreateAccountVC.handleTap)) // STEP 76. action has not been defined yet, see below func handleTap()
        view.addGestureRecognizer(tap)
    }
    
    @objc func handleTap() { // Xcode fix adds @objc
        view.endEditing(true)
    }
}
