//
//  DonationService.swift
//  KifuSF
//
//  Created by Erick Sanchez on 7/28/18.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseStorage

struct DonationService {
    static func createDonation(
        title: String,
        notes: String,
        image: UIImage,
        pickUpAddress: String,
        longitude: Double, latitude: Double, completion: @escaping (OpenDonation) -> ()) {
        
        //upload image to storage and get back url
        let donationImageRef = StorageReference.newDonationImageReference()
        StorageService.uploadImage(image, at: donationImageRef) { (url) in
            guard let storageUrl = url else {
                return assertionFailure("failed to upload image")
            }
            
            //get ref for new donation
            let ref = Database.database().reference().child("openDonations").childByAutoId()
            
            //create donation and get dict value
            let donation = OpenDonation(
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
                
                //and return the object
                completion(donation)
            }
        }
    }
    
    static func showTimelineDonations(completion: @escaping ([OpenDonation]) -> ()) {
        
        //get donations ref
        let ref = Database.database().reference().child("openDonations")
        
        //download snapshot
        ref.observeSingleEvent(of: .value) { (snapshot) in
            guard let snapshotValue = snapshot.children.allObjects as? [DataSnapshot] else {
                fatalError("could not decode into array") //empty array
            }
            
            
            //map snapshot into array of donation
            let openDonations: [OpenDonation] = snapshotValue.compactMap({ (snapshot) -> OpenDonation? in
                guard let donationFromSnapshot = OpenDonation(snapshot: snapshot) else {
                    fatalError("could not decode")
                }
                
                //only include open donations
                if case .Open = donationFromSnapshot.status {
                    
                    //include donations not from current user
                    if donationFromSnapshot.donator.uid != User.current.uid {
                        return donationFromSnapshot
                    } else {
                        return nil
                    }
                } else {
                    return nil
                }
            })
            
            //return
            completion(openDonations)
        }
    }

    static func setStatusToAwaitingPickup(for donation: OpenDonation) {
    
    }
    
    static func setStatusToAwaitingDelivery(for donation: OpenDonation) {
        
    }
    
    static func setStatusToAwaitingApproval(for donation: OpenDonation) {
        
    }
    
    static func remove(donation: OpenDonation) {
        
    }

}
