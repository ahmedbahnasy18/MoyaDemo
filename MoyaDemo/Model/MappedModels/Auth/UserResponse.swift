//
//  ProfileResponse.swift
//  Plays
//
//  Created by Tarek on 8/28/18.
//  Copyright © 2018 plays. All rights reserved.
//

import Foundation
import ObjectMapper

class UserResponse: Mappable {
    
    // MARK:- Properties
    
    var friends: [BuddyModel] = [BuddyModel]()
    
    // MARK:- Mapping
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        var friends: [String:BuddyModel] = [String:BuddyModel]()
        friends <- map["data.friends"]
        for (_, value) in friends {
            self.friends.append(value)
        }
    }
}
