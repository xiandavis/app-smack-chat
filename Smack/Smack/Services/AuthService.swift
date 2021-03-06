//
//  AuthService.swift
//  Smack
//
//  Created by Christian Davis on 3/20/19.
//  Copyright © 2019 xianapps. All rights reserved.
//

import Foundation
import Alamofire // STEP 20. A cocoapod, built on top of URL sessions, easier to work with web requests. See section 6: lesson 63 for installation.
import SwiftyJSON // STEP 39. A cocoapod, simplifies working with JSON

class AuthService { // STEP 17.
    
    static let instance = AuthService() // a singleton (see coder swag > DataService.swift, section5: lesson 57)
    
    let defaults = UserDefaults.standard // most simple way of saving data (string & bool types. NOT for large data i.e. images and NOT for security i.e. passwords) in your app
    
    var isLoggedIn : Bool {
        get {
            return defaults.bool(forKey: LOGGED_IN_KEY) // was forKey: string - Jonny jumps to Constants.swift to define LOGGED_IN_KEY & others
        }
        set { // STEP 19.
            defaults.set(newValue, forKey: LOGGED_IN_KEY) // was value: any?, forKey: string
        }
    }
    
    var authToken: String {
        get {
            return defaults.value(forKey: TOKEN_KEY) as? String ?? "" // Student Katherine R solution resolves crash on 2nd simuator instance, was as! String
        }
        set {
            defaults.set(newValue, forKey: TOKEN_KEY)
        }
    }
    
    var userEmail: String {
        get { // Jonny copies getters/ setters from above, modifies
            return defaults.value(forKey: USER_EMAIL) as? String ?? "" // See above comment
        }
        set {
            defaults.set(newValue, forKey: USER_EMAIL)
        }
    }
    
    func registerUser(email: String, password: String, completion: @escaping CompletionHandler) { // STEP 22a. web requests are asynchronous, meaning we don't know when the response is going to come back. The completion handler tells us when the response containing user email/pw has been received, and then this func can execute the below statements.
        let lowerCaseEmail = email.lowercased()
        
        // STEP 33. Jonny moves header assignment statement into Constants.swift
        
        let body: [String: Any] = [
            "email": lowerCaseEmail,
            "password": password // STEP 22b. replacates same elements seen in Postman app > mac-chat-api > 1.Auth Register User, under BODY
        ]
        
        Alamofire.request(URL_REGISTER, method: .post, parameters: body, encoding: JSONEncoding.default, headers: HEADER).responseString { (response) in // STEP 24a.,  STEP 34. replaces param header with constant HEADER
            
            if response.result.error == nil {
                completion(true) // STEP 24b. same completion as registerUser(email, password, COMPLETION) above
            } else {
                completion(false) // see above comment
                debugPrint(response.result.error as Any)
            }
        } // was url: URLConvertible, method: HTTPMethod, parameters; Parameters?, encoding: ParameterEncoding, headers: HTTPHeaders? - HTTPMethod for POST/GET/etc, Parameters? for the body (email/pw/etc), HTTPHeaders? for the header
    }
    
    func loginUser(email: String, password: String, completion: @escaping CompletionHandler) { // STEP 29. Since this func requests the same data as registerUser() does, Jonny simply copies the assignment statements and pastes them below, word Login replaces Register in their respective comments
        let lowerCaseEmail = email.lowercased() // STEP 31a.
        
        // STEP 35. Jonny moves header assignment statement into Constants.swift
        
        let body: [String: Any] = [
            "email": lowerCaseEmail,
            "password": password // STEP 31b. replacates same elements seen in Postman app > mac-chat-api > 1.Auth Login User, under BODY
        ]
        
        Alamofire.request(URL_LOGIN, method: .post, parameters: body, encoding: JSONEncoding.default, headers: HEADER).responseJSON { (response) in // STEP 36.
            
            if response.result.error == nil {
                // STEP 38. Jonny comments out Option 1 (good to know)
                //                if let json = response.result.value as? Dictionary<String, Any> {
                //                    if let email = json["user"] as? String {
                //                        self.userEmail = email // looking at result shown in Postman app, we know the api returns result of type dictionary with a key of type String (user) and a value of type Any (token)
                //                    }
                //                    if let token = json["token"] as? String {
                //                        self.authToken = token
                //                    }
                //                }
                
                // Option 2, using SwiftyJSON lib. XCODE THREW AN ERROR HERE! The solution according to student Adrian: with error handling in Swift, you use the try keyword to identify places in your code that can throw errors, S6:L73 (see Q&A thread started by Donald, Error. Wanting me to use 'try')
                
                guard let data = response.data else { return } // values assigned to var
                do { // student Adrian enclosed in do statement
                    let json = try JSON(data: data) // student Adrian added try keyword. var from guard statement used as argument in JSON obj, assigned to another var
                    self.userEmail = json["user"].stringValue // parsing out values in JSON obj to properties of class AuthService()
                    self.authToken = json["token"].stringValue // parsing out values in JSON obj to properties of class AuthService()
                } catch { // student Adrian added statement and print statement below
                    debugPrint(error)
                }
                
                self.isLoggedIn = true
                completion(true)
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
    func createUser(name: String, email: String, avatarName: String, avatarColor: String, completion: @escaping CompletionHandler) { // STEP 41a.
        
        let lowerCaseEmail = email.lowercased() // format email for http request
        
        let body: [String: Any] = [ // format below data for http request
            "name": name,
            "email": lowerCaseEmail,
            "avatarName": avatarName,
            "avatarColor": avatarColor // elements the same as requested from mac chat api as seen in Postman
        ]
        
        Alamofire.request(URL_USER_ADD, method: .post, parameters: body, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in // STEP 43a. the actual http request, STEP 99. header replaced with Constant
            
            if response.result.error == nil { // STEP 43b. success means we get data from api that we assign to a JSON obj and parse it out to corresponding properties of userDataService()
                guard let data = response.data else { return } // getting JSON as a response
                self.setUserInfo(data: data) // STEP 103.
                completion(true)
                
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
    func findUserByEmail(completion: @escaping CompletionHandler) { // STEP 96. Presently, the only time we receive result from API containing complete user info is when we post Create/ Add User. We want complete user info after user login; we can do this with API func /user/byEmail/name@domain.com (see Find User By Email in Postman app)
        Alamofire.request("\(URL_USER_BY_EMAIL)\(userEmail)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in // STEP 100.
            
            if response.result.error == nil { // success means we get data from api that we assign to a JSON obj and parse it out to corresponding properties of userDataService()
                guard let data = response.data else { return } // getting JSON as a response
                self.setUserInfo(data: data)
                completion(true)
                
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
    func setUserInfo(data: Data) { // STEP 101.
        do { // STEP 43c. CREATED closure in createUser() based on student Adrian's solution in loginUser() S6:L73, STEP 102. MOVED closure here
            let json = try JSON(data: data) // STEP 43d. from student Adrian's solution in loginUser()
            let id = json["_id"].stringValue // _id based on result from api, displayed in Postman. Unwraps optional; if it doesn't exist, it will not crash because SwiftyJSON will assign it an empty string value.
            let color = json["avatarColor"].stringValue
            let avatarName = json["avatarName"].stringValue
            let email = json["email"].stringValue
            let name = json["name"].stringValue // parsing out values in JSON obj to properties of FUNC setUserData() below
            
            UserDataService.instance.setUserData(id: id, color: color, avatarName: avatarName, email: email, name: name) // values used to set public private(set) vars in CLASS UserDataService.swift where they can then be used througout the app!
        } catch { // this and print below from student Adrian's solution in loginUser()
            debugPrint(error)
        }
    }
}
