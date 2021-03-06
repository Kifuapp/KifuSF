//
//  Report.swift
//  KifuSF
//
//  Created by Erick Sanchez on 8/29/18.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import Foundation
import FirebaseDatabase

enum FlaggedContentType: Int, CustomStringConvertible {
    
    //Flagging the donation
    case flaggedImage = 1
    case flaggedNotes
    case flaggedPickupLocation
    case flaggedVerificationImage
    
    //Flagging the user
    case flaggedPhoneNumber = 100
    case flaggedCommunication
    
    var description: String {
        switch self {
        case .flaggedImage:
            return "Inapropiate Image"
        case .flaggedPickupLocation:
            return "Wrong pickup location"
        case .flaggedNotes:
            return "Misleading Note"
        case .flaggedVerificationImage:
            return "Misleading Verification Image"
        case .flaggedPhoneNumber:
            return "Incorrect Phone Number"
        case .flaggedCommunication:
            return "Unresponsive Communication"
        }
    }
}

protocol FlaggingContentItems {
    var flaggableItems: [FlaggedContentType] { get }
}

struct Report: KeyedStoredProperties {
    let uid: String
    let donation: Donation?
    let user: User?
    
    let flag: FlaggedContentType
    let message: String
    let author: User
    let creatationDate: Date
    
    var dictValue: [String: Any] {
        var dict: [String: Any] = [
            Keys.uid: uid,
            Keys.flag: flag.rawValue,
            Keys.message: message,
            Keys.author: author.dictValue,
            Keys.creatationDate: creatationDate.timeIntervalSince1970
        ]
        if let flaggedUser = self.user {
            dict[Keys.user] = flaggedUser.dictValue
        } else if let flaggedDonation = self.donation {
            dict[Keys.donation] = flaggedDonation.dictValue
        } else {
            fatalError("report has niether a user or donation")
        }
        
        return dict
    }
    
    init(flag donation: Donation, for flagType: FlaggedContentType, message: String, uid: String) {
        self.uid = uid
        self.user = nil
        self.donation = donation
        self.flag = flagType
        self.message = message
        self.author = User.current
        self.creatationDate = Date()
    }
    
    init(flag user: User, for flagType: FlaggedContentType, message: String, uid: String) {
        self.uid = uid
        self.user = user
        self.donation = nil
        self.flag = flagType
        self.message = message
        self.author = User.current
        self.creatationDate = Date()
    }
    
    init?(from snapshot: DataSnapshot) {
        guard
            let dict = snapshot.value as? [String: Any],
            let uid = dict[Keys.uid] as? String,
            let flagInt = dict[Keys.flag] as? Int,
            let flag = FlaggedContentType(rawValue: flagInt),
            let message = dict[Keys.message] as? String,
            let authorSnapshot = dict[Keys.author] as? [String: Any],
            let author = User(from: authorSnapshot),
            let creatationTimestamp = dict[Keys.creatationDate] as? TimeInterval else {
                return nil
        }
        
        if let flaggedUserSnapshot = dict[Keys.user] as? [String: Any] {
            guard let flaggedUser = User(from: flaggedUserSnapshot) else {
                assertionFailure("snapshot was not valid: \(flaggedUserSnapshot)")
                
                return nil
            }
            
            self.donation = nil
            self.user = flaggedUser
        } else if let flaggedDonationSnapshot = dict[Keys.donation] as? [String: Any] {
            guard let flaggedDonation = Donation(from: flaggedDonationSnapshot) else {
                assertionFailure("snapshot was not valid: \(flaggedDonationSnapshot)")
                
                return nil
            }
            
            self.donation = flaggedDonation
            self.user = nil
        } else {
            fatalError("report has niether a user or donation")
        }
        
        self.uid = uid
        self.flag = flag
        self.message = message
        self.author = author
        self.creatationDate = Date(timeIntervalSince1970: creatationTimestamp)
    }
}
