//
//  KFMDonationInfo.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 18/09/2018.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import Foundation

class KFMDonationInfo {
    var imageURL: URL
    var title: String
    var distance: Double
    var description: String
    
    init(imageURL: URL, title: String, distance: Double, description: String) {
        self.imageURL = imageURL
        self.title = title
        self.distance = distance
        self.description = description
    }
}
