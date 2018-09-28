//
//  KFMCollaborator.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 28/09/2018.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import Foundation

class KFMCollaboratorInfo: KFPModularTableViewItem {
    var type: KFCModularTableView.CellTypes = .collaboratorInfo
    
    var username: String
    var name: String
    
    var userReputation: Double
    var userDonationsCount: Int
    var userDeliveriesCount: Int
    
    init(name: String, username: String,
         userReputation: Double, userDonationsCount: Int,
         userDeliveriesCount: Int) {
        
        self.name = name
        self.username = username
        
        self.userReputation = userReputation
        self.userDonationsCount = userDonationsCount
        self.userDeliveriesCount = userDeliveriesCount
    }
}
