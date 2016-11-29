//
//  Profile.swift
//  paragraf
//
//  Created by Gwendal Lasson on 29/11/2016.
//  Copyright © 2016 Adrien Morel. All rights reserved.
//

import UIKit
import SwiftyJSON

class Profile {
    let fullName: String
    let profilePic: String
    let bio: String
    let stories: Array<Int>
    let reputation: Int
    
    init(fullName: String, profilePic: String, bio: String, stories: Array<Int>, reputation: Int) {
        self.fullName = fullName
        self.profilePic = profilePic
        self.bio = bio
        self.stories = stories
        self.reputation = reputation
    }
    
    convenience init(json: JSON) {
        let fullName = json["full_name"].string
        let profilePic = json["profile_pic"].string
        let bio = json["bio"].string
        
        let stringStories = (json["stories"].string!).components(separatedBy: ",")
        let stories = stringStories.map {Int($0)!}
        
        let reputation = json["reputation"].int
        
        self.init(fullName: fullName!, profilePic: profilePic!, bio: bio!, stories: stories, reputation: reputation!)
    }
}

