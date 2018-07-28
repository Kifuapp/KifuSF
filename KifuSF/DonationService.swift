//
//  DonationService.swift
//  KifuSF
//
//  Created by Erick Sanchez on 7/28/18.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import Foundation
import FirebaseDatabase

struct DonationService {
    static func createDonation(
        title: String,
        notes: String,
        image: UIImage,
        pickUpAddress: String,
        longitude: Double, latitude: Double, completion: @escaping (OpenDonation) -> ()) {
        
        //upload image to storage and get back url
        let storageUrl = URL(string: "")!
        
        //get ref
        let ref = Database.database().reference().child("openDonations").childByAutoId()
        
        //create donation and get dict value
        var donation = OpenDonation(
            uid: ref.key,
            title: title,
            notes: notes,
            imageUrl: storageUrl.absoluteString,
            creationDate: Date(),
            longitude: latitude,
            laditude: longitude,
            pickUpAddress: pickUpAddress,
            donator: User.current,
            status: .Open,
            volunteer: nil
        )
        
        let donationDict = donation.dictValue
        
        //send request
        ref.updateChildValues(donationDict) { error, databaseRef in
            completion(donation)
        }
        
        //and return the object
    }
    
    static func showTimelineDonations() {
        
    }
}
