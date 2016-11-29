//
//  Session.swift
//  paragraf
//
//  Created by Gwendal Lasson on 29/11/2016.
//  Copyright © 2016 Adrien Morel. All rights reserved.
//

import UIKit
import SwiftyJSON

class Session {
    let token: String
    let expirationTime: Int
    let userId: Int
    
    init(token: String, expirationTime: Int, userId: Int) {
        self.token = token
        self.expirationTime = expirationTime
        self.userId = userId
    }
    
    convenience init(json: JSON) {
        let token = json["token"].string
        let expirationTime = json["expiration_time"].int
        let userId = json["user_id"].int
        self.init(token: token!, expirationTime: 0 /* FIX as soon as API is ready */, userId: userId!)
    }
}
