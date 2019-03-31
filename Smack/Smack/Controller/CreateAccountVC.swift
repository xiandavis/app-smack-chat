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
    
    // Variables
    var avatarName = "profileDefault" // STEP 44.
    var avatarColor = "[0.5, 0.5, 0.5, 1]" // string array, contains RGB & alpha properties of a color (presently a light gray)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) { // STEP 60. display selected avatar to account, default should already be an empty string
        if UserDataService.instance.avatarName != "" {
            userImg.image = UIImage(named: UserDataService.instance.avatarName)
            avatarName = UserDataService.instance.avatarName
        }
    }

    // Jonny deletes boilerplate code
    @IBAction func pickAvatarPressed(_ sender: Any) { // STEP 48.
        performSegue(withIdentifier: TO_AVATAR_PICKER, sender: nil)
    }
    @IBAction func pickBGColorPressed(_ sender: Any) {
    }
    @IBAction func createAccntPressed(_ sender: Any) {
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
                                print(UserDataService.instance.name, UserDataService.instance.avatarName)
                                self.performSegue(withIdentifier: UNWIND, sender: nil)
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
}
