//
//  Channel.swift
//  Smack
//
//  Created by Christian Davis on 4/3/19.
//  Copyright © 2019 xianapps. All rights reserved.
//

import Foundation

struct Channel : Decodable { // STEP 116. Jonny uses Postman app to view formatting of mac chat api request [.get] Find All Channels, showing it requests channel _id, name and description (my Postman instead shows me 401 Unauthorized, not sure why), STEP 121. Parsing JSON in Swift 4 requires that our Channel conform to the Decodable protocol (see findAllChannel()). This (allegedly, student disputes this) requires the vars be declared in the order they are received in the response from the api, as well as including ALL items (allegedly, student disputes this as well) in the response, even if we don't know what they're for i.e. '__v' is the last item in the api response, possibly a Mongodb id
    
    public private(set) var _id: String!
    public private(set) var name: String! // Jonny using channelTitle instead because he's parsing JSON the Swift 3 way (I'm using Swift 4 way, so allegedly var name must match what is received from api)
    public private(set) var description: String!
    public private(set) var __v: Int? // see comment above. ? because property may not be there
}
