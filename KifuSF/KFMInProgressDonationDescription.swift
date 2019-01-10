//
//  KFMInProgressDonationDescription.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 21/09/2018.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import Foundation

class KFMInProgressDonationDescription: ModularTableViewItem {
    let type: ModularTableViewController.CellTypes = .inProgressDonationDescription
    
    let imageURL: URL
    let title: String
    
    let statusDescription: String
    let description: String
    
    init(imageURL: URL, title: String, statusDescription: String, description: String) {
        
        self.imageURL = imageURL
        self.title = title
        
        self.statusDescription = statusDescription
        self.description = description
    }
}
