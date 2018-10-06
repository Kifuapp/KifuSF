//
//  KFMDonationInfo.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 18/09/2018.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import Foundation

class KFMDonationInfo {
    let imageURL: URL
    let title: String
    let distance: Double
    let description: String
    
    init(imageURL: URL, title: String, distance: Double, description: String) {
        self.imageURL = imageURL
        self.title = title
        self.distance = distance
        self.description = description
    }
}
