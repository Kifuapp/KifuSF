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

struct User: Codable {
    
    enum CodingKeys: String, CodingKey {
        case contributionPoints
        case uid
        case imageURL
        case username
        case contactNumber
    }
    
    // MARK: - VARS
    
    var contributionPoints: Int
    let uid: String
    let imageURL: String
    let username: String
    let contactNumber: String
    
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
        return ["username": username,
                "uid": uid,
                "imageURL": imageURL,
                "contributionPoints": contributionPoints,
                "contactNumber": contactNumber]
    }
    
    public static var current: User {
        guard let currentUser = _current else {
            fatalError("current user doesn't exist")
        }
        return currentUser
    }
    
    private static var _current: User?
    
    init(username: String, uid: String, imageURL: String, contributionPoints: Int, contactNumber: String) {
        self.username = username
        self.uid = uid
        self.imageURL = imageURL
        self.contributionPoints = contributionPoints
        self.contactNumber = contactNumber
    }
    
    init?(from snapshot: DataSnapshot) {
        guard let dict = snapshot.value as? [String: Any],
            let username = dict["username"] as? String,
            let uid = dict["uid"] as? String,
            let imageURL = dict["imageURL"] as? String,
            let contributionPoints = dict["contributionPoints"] as? Int,
            let contactNumber = dict["contactNumber"] as? String
            else { return nil }
        
        self.username = username
        self.uid = uid
        self.imageURL = imageURL
        self.contributionPoints = contributionPoints
        self.contactNumber = contactNumber
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
