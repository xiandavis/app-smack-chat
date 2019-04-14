//
//  UserDataService.swift
//  Smack
//
//  Created by Christian Davis on 3/27/19.
//  Copyright © 2019 xianapps. All rights reserved.
//

import Foundation

class UserDataService { // STEP 40.
    
    static let instance = UserDataService() // a singleton (see coder swag > DataService.swift, section5: lesson 57)
    
    public private(set) var id = "" // encapsulating data, other classes can get value from public var but they cannot set/modify the value of a private var. See see Coder Swag proj > CATEGORY.SWIFT, S5:L57 for Mark's variation of this statement
    public private(set) var avatarColor = "" // these elements can be seen in JSON dictionary result using Postman app
    public private(set) var avatarName = ""
    public private(set) var email = ""
    public private(set) var name = ""
    
    func setUserData(id: String, color: String, avatarName: String, email: String, name: String) { // setting up func params for values to be passed into, then assign those values to the enclosing class' vars above
        self.id = id
        self.avatarColor = color
        self.avatarName = avatarName
        self.email = email
        self.name = name // self refers to class/obj ITSELF which is calling setUserData(), name TO LEFT of = refers to public private(set) var/PROPERTY of class/obj, name TO RIGHT of = refers to func's PARAMETER (can see this by ⌘-clicking each name, jump to definition)
    }
    
    func setAvatarName(avatarName: String) { // Jonny adds this for the near future
        self.avatarName = avatarName
    }
    
    func returnUIColor(components: String) -> UIColor { // STEP 84.
//        "[0.756862745098039, 0.745098039215686, 0.184313725490196, 1]" copied from user data in Robo 3T (formally Robomongo app). visual example of what below code is scanning thru
        
        let scanner = Scanner(string: components) // click Scanner for Quick Help ->
        let skipped = CharacterSet(charactersIn: "[], ]") // was (charactersIn: String)
        let comma = CharacterSet(charactersIn: ",") // read up to ,
        scanner.charactersToBeSkipped = skipped
        var r, g, b, a : NSString? // below Scanner func requires using optional
        
        scanner.scanUpToCharacters(from: comma, into: &r)
        scanner.scanUpToCharacters(from: comma, into: &g)
        scanner.scanUpToCharacters(from: comma, into: &b)
        scanner.scanUpToCharacters(from: comma, into: &a) // & required to get value for our variable becuase this Scanner func uses AutoreleasingUnsafeMutablePointer<NSString?>?) -> Bool (returns true or false, not value we want)
        
        let defaultColor = UIColor.lightGray // default color, in case an optional above does not contain a color value when it is unwrapped; our function requires we return a UIColor
        
        // Unwrapping, if any fail then use defaultColor above
        guard let rUnwrapped = r else { return defaultColor }
        guard let gUnwrapped = g else { return defaultColor }
        guard let bUnwrapped = b else { return defaultColor }
        guard let aUnwrapped = a else { return defaultColor }
        
        // Now have unwrapped values of type String for each of these vars
        // but the init() for UIColor requires they be of type CGFloat
        // Jonny doesn't know of a direct conversion from String to CGFloat
        // Jonny knows of a conversion from String to Double, and from Double to CGFloat
        let rFloat = CGFloat(rUnwrapped.doubleValue)
        let gFloat = CGFloat(gUnwrapped.doubleValue)
        let bFloat = CGFloat(bUnwrapped.doubleValue)
        let aFloat = CGFloat(aUnwrapped.doubleValue)
        
        let newUIColor = UIColor(red: rFloat, green: gFloat, blue: bFloat, alpha: aFloat)
        
        return newUIColor
    }
    
    func logoutUser() { // STEP 91.
        id = ""
        avatarName = ""
        avatarColor = ""
        email = ""
        name = ""
        AuthService.instance.isLoggedIn = false
        AuthService.instance.userEmail = ""
        AuthService.instance.authToken = ""
        MessageService.instance.clearChannels() // STEP 147. called to clear channel array on logout
        MessageService.instance.clearMessages() // STEP 190. called to clear message array on logout
    }
}
