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
    
    private enum Keys {
        static let title = "title"
        static let notes = "notes"
        static let imageUrl = "imageUrl"
        static let creationDate = "creationDate"
        static let longitude = "longitude"
        static let laditude = "laditude"
        static let pickUpAddress = "pickUpAddress"
        static let donator = "donator"
        static let status = "status"
        static let volunteer = "volunteer"
    }
    
    var dictValue: [String: Any] {
        let timeAgo = self.creationDate.timeIntervalSince1970
        return [
            Keys.title: title,
            Keys.notes: notes,
            Keys.imageUrl: imageUrl,
            Keys.creationDate: timeAgo,
            Keys.longitude: longitude,
            Keys.laditude: laditude,
            Keys.pickUpAddress: pickUpAddress,
            Keys.donator: donator.dictValue,
            Keys.status: status.rawValue,
            Keys.volunteer: volunteer?.dictValue as Any
        ]
    }
    
    init(
        uid: String,
        title: String,
        notes: String,
        imageUrl: String,
        creationDate: Date,
        longitude: Double,
        laditude: Double,
        pickUpAddress: String,
        donator: User,
        status: OpenDonation.Status,
        volunteer: User?) {
        self.uid = uid
        self.title = title
        self.notes = notes
        self.imageUrl = imageUrl
        self.creationDate = creationDate
        self.longitude = longitude
        self.laditude = laditude
        self.pickUpAddress = pickUpAddress
        self.donator = donator
        self.status = status
        self.volunteer = volunteer
    }
    
    init?(snapshot: DataSnapshot) {
        guard
        let dict = snapshot.value as? [String: Any],
        let title = dict[Keys.title] as! String?,
        let notes = dict[Keys.notes] as! String?,
        let imageUrl = dict[Keys.imageUrl] as! String?,
        let creationDateTimestamp = dict[Keys.creationDate] as! TimeInterval?,
        let longitude = dict[Keys.longitude] as! Double?,
        let laditude = dict[Keys.longitude] as! Double?,
        let pickUpAddress = dict[Keys.pickUpAddress] as! String?,
        let donatorValue = dict[Keys.donator] as! [String: Any]?,
        let statusValue = dict[Keys.status] as! Int?,
        let volunteerValue = dict[Keys.volunteer] as! [String: Any]?
        else {
            return nil
        }
        
        self.uid = snapshot.key
        self.title = title
        self.notes = notes
        self.imageUrl = imageUrl
        self.creationDate = Date(timeIntervalSince1970: creationDateTimestamp)
        self.longitude = longitude
        self.laditude = laditude
        self.pickUpAddress = pickUpAddress
        self.donator = User()
        self.status = Status(rawValue: statusValue)!
        self.volunteer = User()
        
    }
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
