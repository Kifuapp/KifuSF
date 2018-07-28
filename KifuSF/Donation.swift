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
    let uid: String
    let title: String
    let notes: String
    let imageUrl: String
    let creationDate: Date
    let longitude: Double
    let laditude: Double
    let pickUpAddress: String
    let donator: User
    
    enum Status: Int {
        case Open
        case AwaitingPickup
        case AwaitingDelivery
        case AwaitingApproval
    }
    
    let status: Status
    let volunteer: User?
    
    var dictValue: [String: Any] {
        let timeAgo = self.creationDate.timeIntervalSince1970
        return [
            "title": title,
            "notes": notes,
            "imageURL": imageUrl,
            "creation": timeAgo,
            "longitude": longitude,
            "laditude": laditude,
            "pickUpAddress": pickUpAddress,
            "donator": donator.dictValue,
            "status": status.rawValue,
            "volunteer": volunteer?.dictValue as Any
        ]
    }
    
//    init?(snapshot: DataSnapshot) {
//        
//    }
}

struct Donation {
    
    let title: String
    let notes: String
    let imageUrl: URL
    let creationDate: Date
    let longitude: Double
    let laditude: Double
    let donator: User
    
}
