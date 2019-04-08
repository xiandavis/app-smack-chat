//
//  AddChannelVC.swift
//  Smack
//
//  Created by Christian Davis on 4/4/19.
//  Copyright © 2019 xianapps. All rights reserved.
//

import UIKit

class AddChannelVC: UIViewController {
    
    // Outlets
    @IBOutlet weak var nameTxt: UITextField! // STEP 130.
    @IBOutlet weak var chanDesc: UITextField!
    @IBOutlet weak var bgView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView() // STEP 135. Call it!
    }

    // Jonny deletes boilerplate code here
    @IBAction func closeModalPressed(_ sender: Any) { // STEP 131.
        dismiss(animated: true, completion: nil)
    }
    @IBAction func createChannelPressed(_ sender: Any) {
        guard let channelName = nameTxt.text , nameTxt.text != "" else { return } // STEP 141.
        guard let channelDesc = chanDesc.text else { return } // may not have description
        SocketService.instance.addChannel(channelName: channelName, channelDescription: channelDesc) { (success) in
            if success {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    func setUpView() { // STEP 132. Created statement, STEP 134. After defining closeTap() below, can use it as selector
        let closeTouch = UITapGestureRecognizer(target: self, action: #selector(AddChannelVC.closeTap(_:)))
        bgView.addGestureRecognizer(closeTouch) // tap background to dismiss create channel view
        
        nameTxt.attributedPlaceholder = NSAttributedString(string: "name", attributes: [NSAttributedStringKey.foregroundColor : smackPurplePlaceholder])
        chanDesc.attributedPlaceholder = NSAttributedString(string: "description", attributes: [NSAttributedStringKey.foregroundColor : smackPurplePlaceholder])
    }
    
    @objc func closeTap(_ recognizer: UITapGestureRecognizer) { // STEP 133.
        dismiss(animated: true, completion: nil)
    }
}
