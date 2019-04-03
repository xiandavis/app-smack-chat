//
//  Constants.swift
//  Smack
//
//  Created by Christian Davis on 2/26/19.
//  Copyright © 2019 xianapps. All rights reserved.
//

import Foundation

typealias CompletionHandler = (_ Success: Bool) -> () // STEP 21. CompletionHandler = [type of very simple custom closure, which is a first class func that can be passed around in code]

//typealias foo = String EXAMPLE OF TYPEALIAS USE ABOVE
//let name: foo = "foo"

// URL Constants
let BASE_URL = "http://localhost:3005/v1/" // STEP 23. ON MY OWN HERE-- Jonny uses URL for node.js on Heroku from setup options 1/2 that use mLab, but mLab accts are being migrated (avail Oct 2019). I downloaded the two video lessons to follow when I can create an acct. See /Users/xianAir/Movies/REWATCH around Oct 2019
let URL_REGISTER = "\(BASE_URL)account/register"
let URL_LOGIN = "\(BASE_URL)account/login" // STEP 30. red can be seen in mac chat api using Postman app
let URL_USER_ADD = "\(BASE_URL)user/add" // STEP 42. same comment as above
let URL_USER_BY_EMAIL = "\(BASE_URL)user/byEmail/" // STEP 97. Postman URL shows extra forward slash before user, but adding one here threw error "JSON text did not start with array or object and option to allow fragments not set."

// Colors
let smackPurplePlaceholder = #colorLiteral(red: 0.3254901961, green: 0.4215201139, blue: 0.7752227187, alpha: 0.5) // STEP 68. previously used darker color [literal], 50% opacity

// Notification Constants
let NOTIF_USER_DATA_DID_CHANGE = Notification.Name("notifUserDataChanged") // STEP 77.

// Segues
let TO_LOGIN = "toLogin" // STEP 9.
let TO_CREATE_ACCOUNT = "toCreateAccount" // STEP 12.
let UNWIND = "unwindToChannel" // STEP 15.
let TO_AVATAR_PICKER = "toAvatarPicker" // STEP 47.

// User Defaults
let TOKEN_KEY = "token" // STEP 18.
let LOGGED_IN_KEY = "loggedIn"
let USER_EMAIL = "userEmail"

// Headers
let HEADER = [ // STEP 32.
    "Content-Type": "application/json; charset=utf-8"
]

let BEARER_HEADER = [ // STEP 41b. Created statement in AuthService.createUser(), STEP 98. Moved statement here. format header for http request
    "Authorization": "Bearer \(AuthService.instance.authToken)", // security reqd to add user
    "Content-Type": "application/json; charset=utf-8" // copied from Constants.swift
]
