//
//  KFMCollaborator.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 28/09/2018.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import Foundation

class KFMCollaboratorInfo: KFPModularTableViewItem {
    let type: KFCModularTableView.CellTypes = .collaboratorInfo
    
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
    
    convenience init(from user: User) {
        self.init(
            profileImageURL: URL(string: user.imageURL)!,
            name: "NONAME", //FIXME: store the user's name in the User 
            username: user.username,
            userReputation: user.reputation,
            userDonationsCount: user.numberOfDonations,
            userDeliveriesCount: user.numberOfDeliveries
        )
    }
}
