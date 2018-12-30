//
//  KFVMOpenDonationDescriptionItem.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 18/09/2018.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import Foundation

class KFMOpenDonationDescriptionItem: KFPModularTableViewItem {
    let type: KFCModularTableView.CellTypes = .openDonationDescription
    
    let imageURL: URL
    let title: String
    let username: String
    
    let timestamp: String
    
    let userReputation: Double
    let userDonationsCount: Int
    let userDeliveriesCount: Int
    
    let distance: UserDistance
    
    let description: String
    
    init(imageURL: URL, title: String, username: String,
         creationDate: String, userReputation: Double, userDonationsCount: Int,
         userDeliveriesCount: Int, distance: UserDistance, description: String) {
        
        self.imageURL = imageURL
        self.title = title
        self.username = username
        
        self.timestamp = creationDate
        
        self.userReputation = userReputation
        self.userDonationsCount = userDonationsCount
        self.userDeliveriesCount = userDeliveriesCount
        
        self.distance = distance
        self.description = description
    }
}
