//
//  User.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 28/07/2018.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import Foundation
import FirebaseDatabase
import CoreLocation

struct User: Codable, KeyedStoredProperties {
    
    enum CodingKeys: String, CodingKey {
        case uid
        case imageURL
        case username
        case contactNumber
        case isVerified
        case hasApprovedConditions
        case reputation
        case numberOfDonations
        case numberOfDeliveries
        case hasSeenTutorial
    }
    
    // MARK: - VARS
    
    let uid: String
    let imageURL: String
    let username: String
    let contactNumber: String
    
    var isVerified: Bool
    var hasApprovedConditions: Bool
    var hasSeenTutorial: Bool
    
    var reputation: Double = 0
    var numberOfDonations: Int = 0
    var numberOfDeliveries: Int = 0
    
    //check out this post on why Report cannot be a stored property in Donation
    //https://medium.com/@leandromperez/bidirectional-associations-using-value-types-in-swift-548840734047
    var flag: FlaggedContentType?
    var flaggedReportUid: String?
    
    var currentLocation: CLLocation? = {
        let coreLocation = CLLocationManager()
        
        if CLLocationManager.locationServicesEnabled() {
            return coreLocation.location
        } else {
            return nil
        }
    }()
    
    public var dictValue: [String: Any] {
        return [
            Keys.username: username,
            Keys.uid: uid,
            Keys.imageURL: imageURL,
            Keys.contactNumber: contactNumber,
            Keys.isVerified: isVerified,
            Keys.hasApprovedConditions: hasApprovedConditions,
            Keys.hasSeenTutorial: hasSeenTutorial,
            Keys.flag: flag?.rawValue as Any,
            Keys.flaggedReportUid: flaggedReportUid as Any,
            Keys.reputation: reputation,
            Keys.numberOfDonations: numberOfDonations,
            Keys.numberOfDeliveries: numberOfDeliveries
        ]
    }
    
    public static var current: User {
        guard let currentUser = _current else {
            fatalError("current user doesn't exist")
        }
        return currentUser
    }
    
    private static var _current: User?
    
    init(username: String, uid: String, imageURL: String, contactNumber: String, isVerified: Bool) {
        self.username = username
        self.uid = uid
        self.imageURL = imageURL
        self.contactNumber = contactNumber
        self.isVerified = isVerified
        self.hasApprovedConditions = false
        self.hasSeenTutorial = false
    }
    
    init?(from snapshot: DataSnapshot) {
        guard let dict = snapshot.value as? [String: Any] else {
            return nil
        }
        
        self.init(from: dict)
    }
    
    init?(from dictionary: [String: Any]) {
        guard
            let username = dictionary[Keys.username] as? String,
            let uid = dictionary[Keys.uid] as? String,
            let imageURL = dictionary[Keys.imageURL] as? String,
            let reputation = dictionary[Keys.reputation] as? Double,
            let nDonations = dictionary[Keys.numberOfDonations] as? Int,
            let nDeliveries = dictionary[Keys.numberOfDeliveries] as? Int,
            let contactNumber = dictionary[Keys.contactNumber] as? String,
            let isVerified = dictionary[Keys.isVerified] as? Bool,
            let hasSeenTutorial = dictionary[Keys.hasSeenTutorial] as? Bool,
            let hasApprovedConditions = dictionary[Keys.hasApprovedConditions] as? Bool
            else { return nil }
        
        self.username = username
        self.uid = uid
        self.imageURL = imageURL
        self.contactNumber = contactNumber
        self.isVerified = isVerified
        self.hasSeenTutorial = hasSeenTutorial
        self.hasApprovedConditions = hasApprovedConditions
        self.reputation = reputation
        self.numberOfDonations = nDonations
        self.numberOfDeliveries = nDeliveries
        
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
    
    public static func setCurrent(_ user: User) {
        _current = user
    }
    
    /**
     <#Lorem ipsum dolor sit amet.#>
     
     - parameter <#bar#>: <#Consectetur adipisicing elit.#>
     
     - returns: <#Sed do eiusmod tempor.#>
     */
    public static func writeToPersistance() {
        guard User._current != nil else {
            return
        }
        
        if let data = try? JSONEncoder().encode(User.current) {
            UserDefaults.standard.set(data, forKey: "currentUser")
        }
    }
    
    // MARK: - IBACTIONS
    
    // MARK: - LIFE CYCLE
    
    mutating func flag(with report: Report) {
        self.flag = report.flag
        self.flaggedReportUid = report.uid
    }
}
