//
//  CreateAccountVC.swift
//  Smack
//
//  Created by Christian Davis on 2/28/19.
//  Copyright © 2019 xianapps. All rights reserved.
//

import UIKit

class CreateAccountVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        

    }

    // Jonny deletes boilerplate code
    @IBAction func closePressed(_ sender: Any) { // STEP 16.
        performSegue(withIdentifier: UNWIND, sender: nil)
    }
}
