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
            }
        }
    }
    
    var status: Status
    var volunteer: User?
    
    var dictValue: [String: Any] {
        let timeAgo = self.creationDate.timeIntervalSince1970
        return [
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
    
    init?(from snapshot: DataSnapshot) { // swiftlint:disable:this function_body_length
        guard
            let dict = snapshot.value as? [String: Any],
            let title = dict[Keys.title] as! String?,
            let notes = dict[Keys.notes] as! String?,
            let imageUrl = dict[Keys.imageUrl] as! String?,
            let creationDateTimestamp = dict[Keys.creationDate] as! TimeInterval?,
            let longitude = dict[Keys.longitude] as! Double?,
            let laditude = dict[Keys.latitude] as! Double?,
            let pickUpAddress = dict[Keys.pickUpAddress] as! String?,
            
            let donatorValue = dict[Keys.donator] as! [String: Any]?,
            let donatorUsername = donatorValue["username"] as? String,
            let donatorUid = donatorValue["uid"] as? String,
            let donatorImageURL = donatorValue["imageURL"] as? String,
            let donatorContributionPoints = donatorValue["contributionPoints"] as? Int,
            let donatorContactNumber = donatorValue["contactNumber"] as? String,
            
            let statusValue = dict[Keys.status] as! Int?
            else {
                return nil
        }
        
        var volunteer: User?
        if let volunteerValue = dict[Keys.volunteer] as! [String: Any]?,
            let volunteerUsername = volunteerValue["username"] as? String,
            let volunteerUid = volunteerValue["uid"] as? String,
            let volunteerImageURL = volunteerValue["imageURL"] as? String,
            let volunteerContributionPoints = volunteerValue["contributionPoints"] as? Int,
            let volunteerContactNumber = volunteerValue["contactNumber"] as? String {
            
            volunteer = User(
                username: volunteerUsername,
                uid: volunteerUid,
                imageURL: volunteerImageURL,
                contributionPoints: volunteerContributionPoints,
                contactNumber: volunteerContactNumber
            )
        }
        
        var verificationUrl: String?
        if let verificationUrlValue = dict[Keys.verificationUrl] as! String? {
            verificationUrl = verificationUrlValue
        }
        
        self.uid = snapshot.key
        self.title = title
        self.notes = notes
        self.imageUrl = imageUrl
        self.creationDate = Date(timeIntervalSince1970: creationDateTimestamp)
        self.longitude = longitude
        self.latitude = laditude
        self.pickUpAddress = pickUpAddress
        let donator = User(
            username: donatorUsername,
            uid: donatorUid,
            imageURL: donatorImageURL,
            contributionPoints: donatorContributionPoints,
            contactNumber: donatorContactNumber
        )
        self.donator = donator
        self.status = Status(rawValue: statusValue)!
        self.volunteer = volunteer
        self.verificationUrl = verificationUrl
        
        //flagging
        if let flagInt = dict[Keys.flag] as? Int,
            let flag = FlaggedContentType(rawValue: flagInt),
            let flaggedReportUid = dict[Keys.flaggedReportUid] as? String {
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
