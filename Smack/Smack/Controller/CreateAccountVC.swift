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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

    }

    // Jonny deletes boilerplate code
    @IBAction func pickAvatarPressed(_ sender: Any) {
    }
    @IBAction func pickBGColorPressed(_ sender: Any) {
    }
    @IBAction func createAccntPressed(_ sender: Any) {
        guard let email = emailTxt.text , emailTxt.text != "" else { return } // STEP 26. Jonny says the , reads 'if' or 'where' and is another way of unwrapping an optional value
        guard let pass = passTxt.text , passTxt.text != "" else { return }
        
        AuthService.instance.registerUser(email: email, password: pass) { (success) in // hit return at the editor placeholder that now reads 'success' above
            // a second editor placeholder was here, tabbed to it then deleted and typed below statements
            if success {
                // print("registered user!")
                AuthService.instance.loginUser(email: email, password: pass, completion: { (success) in // STEP 37.
                    if success {
                        print("logged in user!", AuthService.instance.authToken)
                    }
                })
            }
        }
    }
    
    @IBAction func closePressed(_ sender: Any) { // STEP 16.
        performSegue(withIdentifier: UNWIND, sender: nil)
    }
}
