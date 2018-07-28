//
//  Donation.swift
//  KifuSF
//
//  Created by Erick Sanchez on 7/28/18.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import Foundation
import FirebaseDatabase

struct OpenDonation {
    let title: String
    let notes: String
    let imageUrl: URL
    let creationDate: Date
    let longitude: Double
    let laditude: Double
    let donator: User
    
//    init?(snapshot: DataSnapshot) {
//        
//    }
}

struct Donation {
    enum Status: Int {
        case Open
        case AwaitingPickup
        case AwaitingDelivery
        case AwaitingApproval
    }
    
    let status: Status
    
    let title: String
    let notes: String
    let imageUrl: URL
    let creationDate: Date
    let longitude: Double
    let laditude: Double
    let donator: User
    
}
