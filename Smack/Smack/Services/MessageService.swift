//
//  MessageService.swift
//  Smack
//
//  Created by Christian Davis on 4/3/19.
//  Copyright © 2019 xianapps. All rights reserved.
//

import Foundation
import Alamofire // STEP 119. this and below library needed by func findAllChannel()
import SwiftyJSON

class MessageService {
    
    static let instance = MessageService() // STEP 115. Jonny asks What are we going to put in here? Messages and channels that will hold the messages, so we need to create some Models
    
    var channels = [Channel]() // STEP 117. channels is an array of type Channel
    var messages = [Message]() // STEP 169. only stores current channel's messages
    var unreadChannels = [String]() // STEP 209. stores channelIds
    var selectedChannel : Channel? // STEP 146. ? because no channel selected on login
    
    func findAllChannel(completion: @escaping CompletionHandler) { // STEP 120a.
        Alamofire.request(URL_GET_CHANNELS, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in // Note that Jonny uses [method get] 'response' instead of [method post] 'success', as he did in AuthService.swift
            
            if response.result.error == nil {
                guard let data = response.data else { return } // STEP 120c.
                
                // STEP 122. JSON parsing in Swift 4 - see Channel.swift for info on Decode protocol
//                do {
//                    self.channels = try JSONDecoder().decode([Channel].self, from: data)
//                } catch let error {
//                    debugPrint(error as Any)
//                }
//                print(self.channels) // Jonny tests Swift 4 JSON parsing - see ChatVC.swift for Jonny calling this func to test
                
                
                // JSON parsing in <= Swift 3. Jonny prefers parsing this way because he has control of how his models i.e. Channel are structured
                do { // Student Adrian
                    if let json = try JSON(data: data).array { // STEP 120d. uses SwiftyJSON to create a JSON object of type array, because the response from api is an array. try From student Adrian
                        for item in json { // loop [item number of times] through array
                            let name = item["name"].stringValue
                            let channelDescription = item["description"].stringValue
                            let id = item["_id"].stringValue // strings can be seen in api response using Postman app (presently I am Unauthorized for some reason)
                            let channel = Channel(channelTitle: name, channelDescription: channelDescription, id: id) // builds individual channel array
                            self.channels.append(channel) // adds individual channel array to array of channels
                        }
                        //print(self.channels[0].channelTitle) //.name) // Jonny testing JSON parsing the above way
                        NotificationCenter.default.post(name: NOTIF_CHANNELS_LOADED, object: nil) // STEP 156.
                        completion(true) // STEP 120e. outside for loop, inside do closure
                    }
                } catch { // Student Adrian
                    debugPrint(error) // Student Adrian
                }
                
            } else { // STEP 120b.
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
    func findAllMessageForChannel(channelId: String, completion: @escaping CompletionHandler) { // STEP 168a.
        Alamofire.request("\(URL_GET_MESSAGES)\(channelId)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in // Jonny forgot to append the channelId: )\(channelId)". Students say Jonny also forgot forward slash before appending channelId, but his code produces desired result--?
            
            if response.result.error == nil {
                self.clearMessages() // STEP 171.
                guard let data = response.data else { return }
                do { // student Adrian
                    if let json = try JSON(data: data).array { // student Adrian
                        for item in json {
                            let messageBody = item["messageBody"].stringValue
                            let channelId = item["channelId"].stringValue
                            let id = item["_id"].stringValue
                            let userName = item["userName"].stringValue
                            let userAvatar = item["userAvatar"].stringValue
                            let userAvatarColor = item["userAvatarColor"].stringValue
                            let timeStap = item["timeStamp"].stringValue // parsing out JSON message components
                            
                            let message = Message(message: messageBody, userName: userName, channelId: channelId, userAvatar: userAvatar, userAvatarColor: userAvatarColor, id: id, timeStamp: timeStap)
                            self.messages.append(message) // adds latest message to message array
                        }
                        print(self.messages) // test
                        completion(true) // outside of for loop, inside do closure
                    }
                } catch { // student Adrian
                    debugPrint(error) // student Adrian
                }
            } else { // STEP 168b.
                debugPrint(response.result.error as Any)
                completion(false)
            }
        }
    }
    
    func clearMessages() { // STEP 170. clears out our message array, will be called to prevent messges persisting outside of current channel
        messages.removeAll()
    }
    
    func clearChannels() { // STEP 145. clears out our channel array, will be called to prevent channels persisting beyond login session
        channels.removeAll()
    }
}
