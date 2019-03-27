//
//  Constants.swift
//  Smack
//
//  Created by Christian Davis on 2/26/19.
//  Copyright © 2019 xianapps. All rights reserved.
//

import Foundation

typealias CompletionHandler = (_ Success: Bool) -> () // STEP 21. CompletionHandler = [type of very simple custom closure, which is a first class func that can be passed around in code]

//typealias xian = String EXAMPLE OF TYPEALIAS USE ABOVE
//let name: xian = "xian"

// URL Constants
let BASE_URL = "http://localhost:3005/v1/" // STEP 23. ON MY OWN HERE-- Jonny uses URL for node.js on Heroku from setup options 1/2 that use mLab, but mLab accts are being migrated (avail Oct 2019). I downloaded the two video lessons to follow when I can create an acct. See /Users/xianAir/Movies/REWATCH around Oct 2019
let URL_REGISTER = "\(BASE_URL)account/register"
let URL_LOGIN = "\(BASE_URL)account/login" // STEP 30. red can be seen in mac chat api using Postman app

// Segues
let TO_LOGIN = "toLogin" // STEP 9.
let TO_CREATE_ACCOUNT = "toCreateAccount" // STEP 12.
let UNWIND = "unwindToChannel" // STEP 15.

// User Defaults
let TOKEN_KEY = "token" // STEP 18.
let LOGGED_IN_KEY = "loggedIn"
let USER_EMAIL = "userEmail"

// Headers
let HEADER = [ // STEP 32.
    "Content-Type": "application/json; charset=utf-8"
]
