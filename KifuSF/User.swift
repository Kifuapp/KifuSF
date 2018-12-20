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
        case contributionPoints
        case uid
        case imageURL
        case username
        case contactNumber
        case isVerified
    }
    
    // MARK: - VARS
    
    let uid: String
    let imageURL: String
    let username: String
    let contactNumber: String
    
    var isVerified: Bool
    var contributionPoints: Int
    
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
            Keys.contributionPoints: contributionPoints,
            Keys.contactNumber: contactNumber,
            Keys.isVerified: isVerified,
            Keys.flag: flag?.rawValue as Any,
            Keys.flaggedReportUid: flaggedReportUid as Any
        ]
    }
    
    public static var current: User {
        guard let currentUser = _current else {
            fatalError("current user doesn't exist")
        }
        return currentUser
    }
    
    private static var _current: User?
    
    init(username: String, uid: String, imageURL: String, contributionPoints: Int, contactNumber: String, isVerified: Bool) {
        self.username = username
        self.uid = uid
        self.imageURL = imageURL
        self.contributionPoints = contributionPoints
        self.contactNumber = contactNumber
        self.isVerified = isVerified
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
            let contributionPoints = dictionary[Keys.contributionPoints] as? Int,
            let contactNumber = dictionary[Keys.contactNumber] as? String,
            let isVerified = dictionary[Keys.isVerified] as? Bool
            else { return nil }
        
        self.username = username
        self.uid = uid
        self.imageURL = imageURL
        self.contributionPoints = contributionPoints
        self.contactNumber = contactNumber
        self.isVerified = isVerified
        
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
    
    public static func setCurrent(_ user: User, writeToUserDefaults: Bool = false) {
        if writeToUserDefaults {
            if let data = try? JSONEncoder().encode(user) {
                UserDefaults.standard.set(data, forKey: "currentUser")
            }
        }
        
        _current = user
    }
    
    // MARK: - IBACTIONS
    
    // MARK: - LIFE CYCLE
    
    mutating func flag(with report: Report) {
        self.flag = report.flag
        self.flaggedReportUid = report.uid
    }
}
