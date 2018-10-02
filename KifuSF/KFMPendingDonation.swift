//
//  KFMPendingDonation.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 18/09/2018.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import Foundation

class KFMPendingDonation {
    
    let imageURL: URL
    let title: String
    let distance: Double
    
    init(imageURL: URL, title: String, distance: Double) {
        
        self.imageURL = imageURL
        self.title = title
        self.distance = distance
    }
}
