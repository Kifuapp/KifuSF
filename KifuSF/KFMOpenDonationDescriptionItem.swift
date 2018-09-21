//
//  KFVMOpenDonationDescriptionItem.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 18/09/2018.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import Foundation

class KFMOpenDonationDescriptionItem: KFPModularTableViewItem {
    var type: KFCModularTableView.CellTypes = .openDonationDescription
    
    var imageURL: URL
    var title: String
    var username: String
    
    var timestamp: String
    
    var userReputation: Double
    var userDonationsCount: Int
    var userDeliveriesCount: Int
    
    var distance: Double
    
    var description: String
    
    init(imageURL: URL, title: String, username: String,
         creationDate: String, userReputation: Double, userDonationsCount: Int,
         userDeliveriesCount: Int, distance: Double, description: String) {
        
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
