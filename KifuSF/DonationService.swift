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

    static func showOpenDontationAndDelivery(completion: @escaping (OpenDonation?, OpenDonation?) -> ()) {
        let ref = Database.database().reference().child("openDonations")
        
        ref.observeSingleEvent(of: .value) { (snapshot) in
            guard let snapshots = snapshot.children.allObjects as? [DataSnapshot] else {
                fatalError("could not decode")
            }
            
            var openDelivery: OpenDonation? = nil
            var openDonation: OpenDonation? = nil
            
            for aDonationSnapshot in snapshots {
                guard let aDonation = OpenDonation(snapshot: aDonationSnapshot) else {
                    fatalError("could not decode")
                }
                
                if aDonation.donator.uid == User.current.uid {
                    openDonation = aDonation
                } else if let donationVolunteer = aDonation.volunteer {
                    if donationVolunteer.uid == User.current.uid {
                        openDelivery = aDonation
                    }
                }
            }
            
            completion(openDelivery, openDonation)
        }
    }
    
    /**
     this sets the donation's state to awaiting pickup and remove all other unaccepted
     requests from the requets sub-tree
     
     - parameter <#bar#>: <#Consectetur adipisicing elit.#>
     
     - returns: <#Sed do eiusmod tempor.#>
     */
    static func accept(volunteer: User, for donation: OpenDonation, completion: @escaping (Bool) -> ()) {
        //get donation ref
        let ref = Database.database().reference().child("openDonations").child(donation.uid)
        
        var updatedDonation = donation
        
        //update the status of the donation
        //set the volunteer value of the dontaion to the given user
        updatedDonation.status = .AwaitingPickup
        updatedDonation.volunteer = volunteer
        
        ref.updateChildValues(updatedDonation.dictValue) { error, _ in
            guard error == nil else {
                assertionFailure(error!.localizedDescription)
                
                return completion(false)
            }
            
            completion(true)
        }
        
        //remove all requests
        RequestService.deleteRequests(for: donation)
    }
    
    static func setStatusToAwaitingDelivery(for donation: OpenDonation) {
        
    }
    
    static func setStatusToAwaitingApproval(for donation: OpenDonation) {
        
    }
    
    static func remove(donation: OpenDonation) {
        
    }

}
