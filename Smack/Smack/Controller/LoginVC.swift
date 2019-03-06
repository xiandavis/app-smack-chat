//
//  LoginVC.swift
//  Smack
//
//  Created by Christian Davis on 2/27/19.
//  Copyright © 2019 xianapps. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    // Jonny deletes didReceiveMemoryWarning() and other boilerplate code here
    
    @IBAction func closePressed(_ sender: Any) { // STEP 11. ⌃dragged closeBtn from SB to here, set as IBAction
        dismiss(animated: true, completion: nil)
    }
    @IBAction func createAccntBtnPressed(_ sender: Any) { // STEP 13.
        performSegue(withIdentifier: TO_CREATE_ACCOUNT, sender: nil)
    }
    
}
