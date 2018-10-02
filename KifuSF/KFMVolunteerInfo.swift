//
//  KFMVolunteerInfo.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 18/09/2018.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import Foundation

class KFMVolunteerInfo {
    
    let imageURL: URL
    let username: String
    
    let userReputation: Double
    let userDonationsCount: Int
    let userDeliveriesCount: Int
    
    init(imageURL: URL, username: String,
        userReputation: Double, userDonationsCount: Int,
         userDeliveriesCount: Int) {
        
        self.imageURL = imageURL
        self.username = username
        
        self.userReputation = userReputation
        self.userDonationsCount = userDonationsCount
        self.userDeliveriesCount = userDeliveriesCount
    }
}
