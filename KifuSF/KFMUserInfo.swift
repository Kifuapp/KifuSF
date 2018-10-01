//
//  KFMUserInfo.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 01/10/2018.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import Foundation

class KFMUserInfo {
    
    var profileImageURL: URL
    var username: String
    var name: String
    
    var userReputation: Double
    var userDonationsCount: Int
    var userDeliveriesCount: Int
    
    init(profileImageURL: URL, name: String,
         username: String, userReputation: Double,
         userDonationsCount: Int, userDeliveriesCount: Int) {
        
        self.profileImageURL = profileImageURL
        self.name = name
        self.username = username
        
        self.userReputation = userReputation
        self.userDonationsCount = userDonationsCount
        self.userDeliveriesCount = userDeliveriesCount
    }
}
