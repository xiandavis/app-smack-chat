//
//  SocketService.swift
//  Smack
//
//  Created by Christian Davis on 4/8/19.
//  Copyright © 2019 xianapps. All rights reserved.
//

import UIKit
import SocketIO // STEP 137.

class SocketService: NSObject {
    
    static let instance = SocketService()
    
    override init() {
        super.init()
    }
    
    //    var socket : SocketIOClient = SocketIOClient( // Jonny's code is deprecated in SocketIO v13 (method not available in autocomplete). Student Wade H supplied the replacement code below:
    let manager = SocketManager(socketURL: URL(string: BASE_URL)!)
    lazy var socket:SocketIOClient = manager.defaultSocket
    
    func establishConnection() {
        socket.connect()
    }
    
    func closeConnection() {
        socket.disconnect()
    }
    
    func addChannel(channelName: String, channelDescription: String, completion: @escaping CompletionHandler) { // STEP 140. Using Atom, can view the paramaters in this func under the Socket section in
        socket.emit("newChannel", channelName, channelDescription)
        completion(true)
    }
    
    func getChannel(completion: @escaping CompletionHandler) { // STEP 142.
        socket.on("channelCreated") { (dataArray, ack) in // .on meaning we are observing/listening for event called channelCreated, and the data array that comes back from that is the below 4 objects was (event: String, callback: NormalCallback). Hitting return on NormalCallback editor placeholder revealed ([Any], SocketAckEmitter), where the first param is an array of type Any, and SocketAckEmitter means Socket Acknowledge Emmitter, ack means acknowledgement
            guard let channelName = dataArray[0] as? String else { return }
            guard let channelDesc = dataArray[1] as? String else { return }
            guard let channelId = dataArray[2] as? String else { return }
//            guard let __v = dataArray[3] as? Int else { return } // parsing JSON the Swift 4 way, I'm on my own here
            
            let newChannel = Channel(channelTitle: channelName, channelDescription: channelDesc, id: channelId) // parsing JSON the Swift 3 way
            MessageService.instance.channels.append(newChannel)
            completion(true)
        }
    }
    
    func addMessage(messageBody: String, userId: String, channelId: String, completion: @escaping CompletionHandler) { // STEP 175.
        let user = UserDataService.instance
        socket.emit("newMessage", messageBody, userId, channelId, user.name, user.avatarName, user.avatarColor)
        completion(true)
    }
    
    func getChatMessage(completion: @escaping CompletionHandler) { // STEP 187. listening for event from server called messageCreated. if we receive it, with it we receive a dataArray. we parse out the data we want.
        socket.on("messageCreated") { (dataArray, ack) in
            guard let msgBody = dataArray[0] as? String else { return }
            guard let channelId = dataArray[2] as? String else { return } // not using userId dataArray[1] in our message model
            guard let userName = dataArray[3] as? String else { return }
            guard let userAvatar = dataArray[4] as? String else { return }
            guard let userAvatarColor = dataArray[5] as? String else { return }
            guard let id = dataArray[6] as? String else { return }
            guard let timeStamp = dataArray[7] as? String else { return }
            
            if channelId == MessageService.instance.selectedChannel?.id && AuthService.instance.isLoggedIn { // check to make sure the incoming message is on the current channel (only channel we care about).
                let newMessage = Message(message: msgBody, userName: userName, channelId: channelId, userAvatar: userAvatar, userAvatarColor: userAvatarColor, id: id, timeStamp: timeStamp)
                MessageService.instance.messages.append(newMessage) // add new message to message array
                completion(true)
            } else {
                completion(false)
            }
        }
    }

}
