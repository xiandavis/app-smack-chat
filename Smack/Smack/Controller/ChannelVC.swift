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
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue){ // STEP 14. Jonny adds this statement manually, unconnected
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.revealViewController().rearViewRevealWidth = self.view.frame.size.width - 60 // STEP 5. experiement with different values here

        // Do any additional setup after loading the view.
    }

    // Jonny deletes boilerplate code here
    @IBAction func loginBtnPressed(_ sender: Any) { // STEP 8b.
        performSegue(withIdentifier: TO_LOGIN, sender: nil) // STEP 10
    }
    

}
