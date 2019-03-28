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
    
    public private(set) var id = "" // encapsulating data, other classes can get value from public var but they cannot set/modify the value of a private var. See see Coder Swag proj > CATEGORY.SWIFT, STEP 4 in S5:L57 for Mark's variation of this statement
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
}
