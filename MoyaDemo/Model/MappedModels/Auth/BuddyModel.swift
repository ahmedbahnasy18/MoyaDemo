//
//  BuddyModel.swift
//  Plays
//
//  Created by Tarek on 8/28/18.
//  Copyright © 2018 plays. All rights reserved.
//

import Foundation
import ObjectMapper

class BuddyModel: Mappable {
    
    enum Status: Int {
        case offline = 0
        case online = 1
        case playing = 2
    }
    
    var avatar: String?
    var displayName: String?
    var id: String?
    var userId: String?
    var status: Status = .offline
    var updatedAt: String?
    var streamId: String?
    var peers: Int?
    var gameTitle: String?
    
    init() {}
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        avatar <- map["avatar"]
        displayName <- map["displayValue"]
        displayName <- map["displayName"]
        id <- map["id"]
        userId <- map["userId"]
        updatedAt <- map["updatedAt"]
        streamId <- map["streamId"]
        peers <- map["peers"]
        gameTitle <- map["game.title"]
        
        var statusString: String = "offline"
        statusString <- map["status"]

        switch statusString {
        case "online":
            status = .online
        case "playing":
            status = .playing
        default:
            status = .offline
        }
    }
}
