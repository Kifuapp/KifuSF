//
//  KFMUserInfo.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 01/10/2018.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import Foundation

class KFMUserInfo {
    
    let profileImageURL: URL
    let username: String
    let name: String
    
    let userReputation: Double
    let userDonationsCount: Int
    let userDeliveriesCount: Int
    
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
