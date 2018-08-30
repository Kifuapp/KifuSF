//
//  Report.swift
//  KifuSF
//
//  Created by Erick Sanchez on 8/29/18.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import Foundation
import FirebaseDatabase

enum FlaggedContentType: Int {
    
    //Flagging the donation
    case flaggedImage = 1
    case flaggedNotes
    case flaggedPickupLocation
    case flaggedVerificationImage
    
    //Flagging the user
    case flaggedPhoneNumber = 100
    case flaggedCommunication
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
    
    init?(snapshot: DataSnapshot) {
        guard
            let dict = snapshot.value as? [String: Any],
            let uid = dict[Keys.uid] as? String,
            let flagInt = dict[Keys.flag] as? Int,
            let flag = FlaggedContentType(rawValue: flagInt),
            let message = dict[Keys.message] as? String,
            let authorSnapshot = dict[Keys.author] as? DataSnapshot,
            let author = User(from: authorSnapshot),
            let creatationTimestamp = dict[Keys.creatationDate] as? TimeInterval else {
                return nil
        }
        
        if let flaggedUserSnapshot = dict[Keys.user] as? DataSnapshot {
            guard let flaggedUser = User(from: flaggedUserSnapshot) else {
                assertionFailure("snapshot was not valid: \(flaggedUserSnapshot)")
                
                return nil
            }
            
            self.donation = nil
            self.user = flaggedUser
        } else if let flaggedDonationSnapshot = dict[Keys.donation] as? DataSnapshot {
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
