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
    var selectedChannel : Channel? // STEP 146. ? because no channel selected on login
    
    func findAllChannel(completion: @escaping CompletionHandler) { // STEP 120.
        Alamofire.request(URL_GET_CHANNELS, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in // Note that Jonny uses [method get] 'response' instead of [method post] 'success', as he did in AuthService.swift
            
            if response.result.error == nil {
                guard let data = response.data else { return }
                
                // STEP 122. JSON parsing in Swift 4 - see Channel.swift for info on Decode protocol
//                do {
//                    self.channels = try JSONDecoder().decode([Channel].self, from: data)
//                } catch let error {
//                    debugPrint(error as Any)
//                }
//                print(self.channels) // Jonny tests Swift 4 JSON parsing - see ChatVC.swift for Jonny calling this func to test
                
                
                // JSON parsing in <= Swift 3. Jonny prefers parsing this way because he has control of how his models i.e. Channel are structured
                do {
                    if let json = try JSON(data: data).array { // uses SwiftyJSON to create a JSON object of type array, because the response from api is an array
                        for item in json { // loop [item number of times] through array
                            let name = item["name"].stringValue
                            let channelDescription = item["description"].stringValue
                            let id = item["_id"].stringValue // strings can be seen in api response using Postman app (presently I am Unauthorized for some reason)
                            let channel = Channel(channelTitle: name, channelDescription: channelDescription, id: id) // builds individual channel array
                            self.channels.append(channel) // adds individual channel array to array of channels
                        }
                        //print(self.channels[0].channelTitle) //.name) // Jonny testing JSON parsing the above way
                        NotificationCenter.default.post(name: NOTIF_CHANNELS_LOADED, object: nil) // STEP 156.
                    }
                } catch {
                    debugPrint(error) // Student Adrian
                }
                completion(true)
                
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
    func clearChannels() { // STEP 145. clears out our channel array, will be called to prevent channels persisting beyond login session
        channels.removeAll()
    }
}
