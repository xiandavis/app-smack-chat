//
//  ChatVC.swift
//  Smack
//
//  Created by Christian Davis on 2/18/19.
//  Copyright © 2019 xianapps. All rights reserved.
//

import UIKit

class ChatVC: UIViewController, UITableViewDelegate, UITableViewDataSource { // STEP 182.
    
    // Outlets - Jonny finds ^dragging from DO to here more accurate than ^dragging from the button in SB to here
    @IBOutlet weak var menuBtn: UIButton! // STEP 2. Jonny understands it may seem strange to have a button be an outlet rather than an action, but he says we will manually implement the action associated with the button inside viewDidLoad() below
    
    @IBOutlet weak var channelNameLbl: UILabel! // STEP 153.
    @IBOutlet weak var messageTxtBox: UITextField!
    @IBOutlet weak var tableView: UITableView! // STEP 181.
    @IBOutlet weak var sendBtn: UIButton! // STEP 192.
    @IBOutlet weak var typingUsersLbl: UILabel! // STEP 196.
    
    // Variables
    var isTyping = false // STEP 194.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.bindToKeyboard() // STEP 176.
        tableView.delegate = self // STEP 183.
        tableView.dataSource = self
        
        tableView.estimatedRowHeight = 80 // STEP 186.
        tableView.rowHeight = UITableViewAutomaticDimension
        sendBtn.isHidden = true // STEP 195.
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(ChatVC.handleTap)) // STEP 178.
        view.addGestureRecognizer(tap)
        menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside) // STEP 3. The param Target is self.revealViewController(), param Selector is a objC method we are going to invoke (the method specifically being revealToggle()--Jonny ⌘clicks revealToggle() to Jump to Definition to read comments above it describing how to use it), param UIControlEvents is .touchUpInside
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer()) // STEP 4. gestureRecognizer: UIGestureRecognizer is self.revealViewController().panGestureRecognizer(), panGestureRecognizer is for slide motion
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer()) // same as above, tapGestureRecognizer is for tap motion
        
        NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.userDataDidChange(_:)), name: NOTIF_USER_DATA_DID_CHANGE, object: nil) // STEP 149. Created statement, STEP 151. updated #selector, after moving userDataDidChange() OUTSIDE of viewDidLoad() *DUH!*
        NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.channelSelected(_:)), name: NOTIF_CHANNEL_SELECTED, object: nil) // STEP 162. Creates after defining #selector below
        
//        SocketService.instance.getChatMessage { (success) in // STEP 188a.
//            if success {
//                self.tableView.reloadData()
//                if MessageService.instance.messages.count > 0 { // STEP 189. scroll to bottom to reveal latest message
//                    let endIndex = IndexPath(row: MessageService.instance.messages.count - 1, section: 0)
//                    self.tableView.scrollToRow(at: endIndex, at: .bottom, animated: false)
//                }
//            } // STEP 188b. Jonny runs code, types message and it immediately appears!
//        }
        SocketService.instance.getChatMessage { (newMessage) in // STEP 207. Change of completion handler's parameter to type Message renders above call obsolete. was (completion: (Message) -> Void), ⏎ at editor placeholder becomes (Message), entered newMessage
            
            if newMessage.channelId == MessageService.instance.selectedChannel?.id && AuthService.instance.isLoggedIn {
                MessageService.instance.messages.append(newMessage)
                self.tableView.reloadData()
                if MessageService.instance.messages.count > 0 {
                    let endIndex = IndexPath(row: MessageService.instance.messages.count - 1, section: 0)
                    self.tableView.scrollToRow(at: endIndex, at: .bottom, animated: false)
                }
            }
        }
        
        SocketService.instance.getTypingUsers { (typingUsers) in // STEP 198. was (completionHandler: ([String : String]) -> Void); after hitting ⏎ the editor placeholder becomes ([String : String]); we then replace with (typingUsers)
            guard let channelId = MessageService.instance.selectedChannel?.id else { return } // check to see if users are in selected channel; if no channel selected, we exit
            var names = "" // hold names of who is typing
            var numberOfTypers = 0
            
            for (typingUser, channel) in typingUsers { // loop thru dictionary key/value pairs
                if typingUser != UserDataService.instance.name /* me */ && channel == channelId /* selected channel */ { // then we will add users' name(s) to var names
                    if names == "" { // if it's either the first person in the dictionary loop or it's the only person typing
                        names = typingUser
                    } else {
                        names = "\(names), \(typingUser)" // if someone's name is already in dictionary
                    }
                    numberOfTypers += 1
                }
            }
            
            if numberOfTypers > 0 && AuthService.instance.isLoggedIn == true { // verbage of label. is == true necessary?
                var verb = "is"
                if numberOfTypers > 1 {
                    verb = "are"
                }
                self.typingUsersLbl.text = "\(names) \(verb) typing a message"
            } else {
                self.typingUsersLbl.text = ""
            }
        }
        
        if AuthService.instance.isLoggedIn { // STEP 107. Jonny notes than when we send app to background and re-enter, a boolean variable saying if we are still logged in or not is set to true, but the app no longer shows all user info. To solve we need to check if we are Logged in; if so, we call Find User By Email and do our post notification that user data changed.
            AuthService.instance.findUserByEmail(completion: { (success) in
                NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
            })
        }
        
//        MessageService.instance.findAllChannel { (success) in
//            /*
//            STEP 123. Jonny just testing JSON parsing in Swift 4 to display channel properties in console. This threw error because there were no channels created yet - solution by student Jemimah 'Share: How to solve error when your api url for your channels displays as "Unauthorized" and/or channels do not display during runtime' is as follows: in Postman app, register/login/add a user. Copy user auth token in response and paste in Add Channel's header on line KEY Authentication for VALUE after 'Bearer ', hit send to create default channel. Then run Smack app (this is all while mac-chat-api/node.js [npm run dev] is running in Terminal in tab #1 and local db/mongodb [--dbpath /Users/xianAir/mac-chat-api/data/db/ --port 27017] is running in tab #2)
//             */
//        }
        
    }
    // Selectors
    @objc func userDataDidChange(_ notif: Notification) { // STEP 150. copied from ChannelVC.userDataDidChange(), for use in .addObserver() above
        if AuthService.instance.isLoggedIn { // STEP 152.
            // get channels
            onLoginGetMessages() // STEP 155a
        } else {
            channelNameLbl.text = "Please Log In" // STEP 154a.
            tableView.reloadData() // STEP 191.
        }
    }
    
    @objc func channelSelected(_ notif: Notification) { // STEP 161.
        updateWithChannel() // STEP 164.
    }
    
    @objc func handleTap() { // STEP 177. to dismiss keyboard after typing in message box
        view.endEditing(true) // click endEditing -> Quick Help, Description
    }
    
    func updateWithChannel() { // STEP 163.
        let channelName = MessageService.instance.selectedChannel?.channelTitle ?? "" // if can't find non-optional string, then set to empty string
        channelNameLbl.text = "#\(channelName)" // STEP 165.
        getMessages() // STEP 173.
    }
    
    @IBAction func messageBoxEditing(_ sender: Any) { // STEP 193a.
        guard let channelId = MessageService.instance.selectedChannel?.id else { return } // STEP 199.
        if messageTxtBox.text == "" { // STEP 193b.
            isTyping = false
            sendBtn.isHidden = true
            SocketService.instance.socket.emit("stopType", UserDataService.instance.name, channelId) // STEP 200.
        } else { // STEP 193c.
            if isTyping == false {
                sendBtn.isHidden = false
                SocketService.instance.socket.emit("startType", UserDataService.instance.name, channelId) // STEP 201.
            } // STEP 193d.
            isTyping = true
        }
    }
    
    @IBAction func sendMsgPressed(_ sender: Any) { // STEP 174.
        if AuthService.instance.isLoggedIn { // STEP 179.
            guard let channelId = MessageService.instance.selectedChannel?.id else { return }
            guard let message = messageTxtBox.text else { return }
            
            SocketService.instance.addMessage(messageBody: message, userId: UserDataService.instance.id, channelId: channelId, completion: { (success) in
                if success {
                    self.messageTxtBox.text = ""
                    self.messageTxtBox.resignFirstResponder()
                    SocketService.instance.socket.emit("stopType", UserDataService.instance.name, channelId) // STEP 202.
                }
            })
        }
    }
    
    func onLoginGetMessages() { // STEP 154b.
        MessageService.instance.findAllChannel { (success) in
            if success {
                // Do stuff with channels
                if MessageService.instance.channels.count > 0 { // STEP 172. if there is at least one existing channel
                    MessageService.instance.selectedChannel = MessageService.instance.channels[0] // set the current channel to the first channel in the array
                    self.updateWithChannel()
                } else {
                    self.channelNameLbl.text = "No channels yet!"
                }
            }
        }
    }
    
    func getMessages() {
        guard let channelId = MessageService.instance.selectedChannel?.id else { return }
        MessageService.instance.findAllMessageForChannel(channelId: channelId) { (success) in
            if success { // STEP 185.
                self.tableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell { // STEP 184.
        if let cell = tableView.dequeueReusableCell(withIdentifier: "messageCell", for: indexPath) as? MessageCell {
            let message = MessageService.instance.messages[indexPath.row]
            cell.configureCell(message: message)
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MessageService.instance.messages.count
    }
}
