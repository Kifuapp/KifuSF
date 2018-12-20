//
//  Donation.swift
//  KifuSF
//
//  Created by Erick Sanchez on 7/28/18.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import Foundation
import FirebaseDatabase

struct Donation: KeyedStoredProperties {
    
    // MARK: - VARS
    
    let uid: String
    let title: String
    let notes: String
    let imageUrl: String
    let creationDate: Date
    let longitude: Double
    let latitude: Double
    let pickUpAddress: String
    let donator: User
    var verificationUrl: String?
    
    //check out this post on why Report cannot be a stored property in Donation
    //https://medium.com/@leandromperez/bidirectional-associations-using-value-types-in-swift-548840734047
    var flag: FlaggedContentType?
    var flaggedReportUid: String?
    
    enum Status: Int, SwitchlessCases {
        case open
        case awaitingPickup
        case awaitingDelivery
        case awaitingApproval
        case awaitingReview
        
        //TODO: Flagging, add a flag case here?
//        case flagged
        
        var stringValueForDonator: String {
            switch self {
            case .open:
                return "Open"
            case .awaitingPickup:
                return "Awaiting your dropoff"
            case .awaitingDelivery:
                return "Awaiting verification photo"
            case .awaitingApproval:
                return "Awaiting your approval"
            case .awaitingReview:
                return "Awaiting your review"
            }
        }
        
        var stringValueForVolunteer: String {
            switch self {
            case .open:
                return "Open"
            case .awaitingPickup:
                return "Awaiting your pickup"
            case .awaitingDelivery:
                return "Awaiting your verification"
            case .awaitingApproval:
                return "Awaiting donator's approval"
            case .awaitingReview:
                return "Awaiting your review"
            }
        }
    }
    
    var status: Status
    var volunteer: User?
    
    var dictValue: [String: Any] {
        let timeAgo = self.creationDate.timeIntervalSince1970
        return [
            Keys.uid: uid,
            Keys.title: title,
            Keys.notes: notes,
            Keys.imageUrl: imageUrl,
            Keys.creationDate: timeAgo,
            Keys.longitude: longitude,
            Keys.latitude: latitude,
            Keys.pickUpAddress: pickUpAddress,
            Keys.donator: donator.dictValue,
            Keys.status: status.rawValue,
            Keys.volunteer: volunteer?.dictValue as Any,
            Keys.verificationUrl: verificationUrl as Any,
            Keys.flag: flag?.rawValue as Any,
            Keys.flaggedReportUid: flaggedReportUid as Any
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
        status: Donation.Status,
        volunteer: User?,
        verificationUrl: String? = nil) {
        self.uid = uid
        self.title = title
        self.notes = notes
        self.imageUrl = imageUrl
        self.creationDate = creationDate
        self.longitude = longitude
        self.latitude = laditude
        self.pickUpAddress = pickUpAddress
        self.donator = donator
        self.status = status
        self.volunteer = volunteer
        self.verificationUrl = verificationUrl
    }
    
    init?(from snapshot: DataSnapshot) {
        guard let dict = snapshot.value as? [String: Any] else {
            return nil
        }
        
        self.init(from: dict)
    }
    
    init?(from dictionary: [String: Any]) {
        guard
            let uid = dictionary[Keys.uid] as! String?,
            let title = dictionary[Keys.title] as! String?,
            let notes = dictionary[Keys.notes] as! String?,
            let imageUrl = dictionary[Keys.imageUrl] as! String?,
            let creationDateTimestamp = dictionary[Keys.creationDate] as! TimeInterval?,
            let longitude = dictionary[Keys.longitude] as! Double?,
            let laditude = dictionary[Keys.latitude] as! Double?,
            let pickUpAddress = dictionary[Keys.pickUpAddress] as! String?,
            
            let donatorValue = dictionary[Keys.donator] as! [String: Any]?,
            let donator = User(from: donatorValue),
            
            let statusValue = dictionary[Keys.status] as! Int?,
            let status = Status(rawValue: statusValue)
            else {
                return nil
        }
        
        if let volunteerValue = dictionary[Keys.volunteer] as! [String: Any]? {
            guard let volunteer = User(from: volunteerValue) else {
                assertionFailure("failed to decode user")
                
                return nil
            }
            
            self.volunteer = volunteer
        }
        
        var verificationUrl: String?
        if let verificationUrlValue = dictionary[Keys.verificationUrl] as! String? {
            verificationUrl = verificationUrlValue
        }
        
        self.uid = uid
        self.title = title
        self.notes = notes
        self.imageUrl = imageUrl
        self.creationDate = Date(timeIntervalSince1970: creationDateTimestamp)
        self.longitude = longitude
        self.latitude = laditude
        self.pickUpAddress = pickUpAddress
        self.donator = donator
        self.status = status
        self.verificationUrl = verificationUrl
        
        //flagging
        if let flagInt = dictionary[Keys.flag] as? Int,
            let flag = FlaggedContentType(rawValue: flagInt),
            let flaggedReportUid = dictionary[Keys.flaggedReportUid] as? String {
            self.flag = flag
            self.flaggedReportUid = flaggedReportUid
        }
    }
    
    // MARK: - RETURN VALUES
    
    // MARK: - METHODS
    
    mutating func flag(with report: Report) {
        self.flag = report.flag
        self.flaggedReportUid = report.uid
    }
    
    // MARK: - IBACTIONS
    
    // MARK: - LIFE CYCLE
}

extension Donation: Equatable {
    
    static func == (lhs: Donation, rhs: Donation) -> Bool {
        return lhs.uid == rhs.uid
    }
}
