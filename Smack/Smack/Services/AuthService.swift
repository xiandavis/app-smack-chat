//
//  AuthService.swift
//  Smack
//
//  Created by Christian Davis on 3/20/19.
//  Copyright © 2019 xianapps. All rights reserved.
//

import Foundation
import Alamofire // STEP 20. A cocoapod, built on top of URL sessions, easier to work with web requests. See section 6: lesson 63 for installation.

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
            return defaults.value(forKey: TOKEN_KEY) as! String
        }
        set {
            defaults.set(newValue, forKey: TOKEN_KEY)
        }
    }
    
    var userEmail: String {
        get { // Jonny copies getters/ setters from above, modifies
            return defaults.value(forKey: USER_EMAIL) as! String
        }
        set {
            defaults.set(newValue, forKey: USER_EMAIL)
        }
    }
    
    func registerUser(email: String, password: String, completion: @escaping CompletionHandler) { // STEP 22. web requests are asynchronous, meaning we don't know when the response is going to come back. The completion handler tells us when the response containing user email/pw has been received, and then this func can execute the below statements.
        let lowerCaseEmail = email.lowercased()
        
        let header = [
            "Content-Type": "application/json; charset=utf-8" // replacates same elements seen in Postman app > mac-chat-api > 1.Auth Register User, under HEADERS
        ]
        
        let body: [String: Any] = [
            "email": lowerCaseEmail,
            "password": password // replacates same elements seen in Postman app > mac-chat-api > 1.Auth Register User, under BODY
        ]
        
        Alamofire.request(URL_REGISTER, method: .post, parameters: body, encoding: JSONEncoding.default, headers: header).responseString { (response) in // STEP 24.
            
            if response.result.error == nil {
                completion(true) // same completion as registerUser(email, password, COMPLETION) above
            } else {
                completion(false) // see above comment
                debugPrint(response.result.error as Any)
            }
        } // was url: URLConvertible, method: HTTPMethod, parameters; Parameters?, encoding: ParameterEncoding, headers: HTTPHeaders? - HTTPMethod for POST/GET/etc, Parameters? for the body (email/pw/etc), HTTPHeaders? for the header
        
    }
    
    
}
