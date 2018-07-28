//
//  StorageRefence.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 28/07/2018.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import Foundation
import FirebaseStorage

extension StorageReference {
    private static let dateFormatter = ISO8601DateFormatter()
    
    public static func newUserImageRefence(with uid: String) -> StorageReference {
        let timestamp = dateFormatter.string(from: Date())
        
        return Storage.storage().reference().child("images/users/\(uid)/\(timestamp).jpg")
    }
    
    public static func newDonationImageReference(for donation: Donation) -> StorageReference {
        let timestamp = dateFormatter.string(from: Date())
        let uid = donation.donator.uid
        
        return Storage.storage().reference().child("images/donations/\(uid)/\(timestamp).jpg")
    }
}
