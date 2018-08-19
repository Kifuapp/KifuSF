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
        longitude: Double, latitude: Double, completion: @escaping (Donation) -> ()) {

        //upload image to storage and get back url
        let donationImageRef = StorageReference.newDonationImageReference()
        StorageService.uploadImage(image, at: donationImageRef) { (url) in
            guard let storageUrl = url else {
                return assertionFailure("failed to upload image")
            }

            //get ref for new donation
            let ref = Database.database().reference().child("open-donations").childByAutoId()

            //create donation and get dict value
            let donation = Donation(
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

    static func showTimelineDonations(completion: @escaping ([Donation]) -> ()) {

        //get donations ref
        let ref = Database.database().reference().child("open-donations")

        //download snapshot
        ref.observe(.value) { (snapshot) in
            guard let snapshotValue = snapshot.children.allObjects as? [DataSnapshot] else {
                fatalError("could not decode into array") //empty array
            }


            //map snapshot into array of donation
            let openDonations: [Donation] = snapshotValue.compactMap({ (snapshot) -> Donation? in
                guard let donationFromSnapshot = Donation(snapshot: snapshot) else {
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

    static func showOpenDontationAndDelivery(completion: @escaping (Donation?, Donation?) -> ()) {
        let ref = Database.database().reference().child("open-donations")

        ref.observe(.value) { (snapshot) in
            guard let snapshots = snapshot.children.allObjects as? [DataSnapshot] else {
                fatalError("could not decode")
            }

            var openDelivery: Donation? = nil
            var openDonation: Donation? = nil

            for aDonationSnapshot in snapshots {
                guard let aDonation = Donation(snapshot: aDonationSnapshot) else {
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

            completion(openDonation, openDelivery)
        }
    }

    static func getNumberOfVolunteers(for donation: Donation, completion: @escaping (Int) -> ()) {
        let ref = Database.database().reference().child("donation-requests").child(donation.uid)
        
        ref.observe(.value) { (dataSnapshot) in
            let childrenCount = dataSnapshot.childrenCount
            
            completion(Int(childrenCount))
        }
    }
    
    /**
     this sets the donation's state to awaiting pickup and remove all other unaccepted
     requests from the requets sub-tree
     */
    static func accept(volunteer: User, for donation: Donation, completion: @escaping (Bool) -> ()) {
        //get donation ref
        let ref = Database.database().reference().child("open-donations").child(donation.uid)

        var updatedDonation = donation

        //update the status of the donation
        //set the volunteer value of the dontaion to the given user
        updatedDonation.status = .AwaitingPickup
        updatedDonation.volunteer = volunteer
        
        var isSuccessful = true
        let dg = DispatchGroup()
        
        dg.enter()
        ref.updateChildValues(updatedDonation.dictValue) { error, _ in
            if let error = error {
                print("there was an error \(error.localizedDescription)")
                
                isSuccessful = false
            }

            dg.leave()
        }

        //remove all requests
        dg.enter()
        
        RequestService.clearRequests(for: donation) { success in
            if success == false {
                isSuccessful = false
            }
            
            dg.leave()
        }
        
        dg.notify(queue: DispatchQueue.main) {
            completion(isSuccessful)
        }
    }

    /**
     this updates the status of a donation to the delivering process aka "awaiting delivery"
     */
    static func confirmPickup(for donation: Donation, completion: @escaping (Bool) -> ()) {
        let ref = Database.database().reference().child("open-donations").child(donation.uid)

        var updatedDonation = donation
        updatedDonation.status = .AwaitingDelivery

        ref.updateChildValues(updatedDonation.dictValue) { (error, _) in
            if let error = error {
                assertionFailure(error.localizedDescription)
                return completion(false)
            }
            completion(true)
        }


    }
    
    static func confirmDelivery(for donation: Donation, image: UIImage, completion: @escaping (Bool) -> ()) {
        let imageRef = StorageReference.newDeliveryVerificationImageReference(from: donation)
        
        StorageService.uploadImage(image, at: imageRef) { (downloadURL) in
            guard let downloadURL = downloadURL else {
                assertionFailure("failed to upload")
                return completion(false)
            }
            
            var updatedDonation = donation
            updatedDonation.status = .AwaitingApproval
            updatedDonation.verificationUrl = downloadURL.absoluteString
            
            let ref = Database.database().reference().child("open-donations").child(donation.uid)
            ref.updateChildValues(updatedDonation.dictValue, withCompletionBlock: { (error, _) in
                if let error = error {
                    assertionFailure("failed to update donation for confirming the delivery, error: \(error.localizedDescription)")
                    return completion(false)
                }
                completion(true)
            })
        }
        
    }

    static func verifyDelivery(for donation: Donation, completion: @escaping (Bool) -> ()) {
        let ref = Database.database().reference().child("open-donations").child(donation.uid)
        ref.setValue(nil) { (error, _) in
            if let error = error {
                assertionFailure("failed to remove donation from the branch, error: \(error.localizedDescription)")
                return completion(false)
            }
            completion(true)
        }
    }
    
    static func getDistance(for donation: Donation, completion: @escaping (String) -> ()) {
        
    }

    static func cancel(donation: Donation, completion: @escaping (Bool) -> Void) {
        
        let dg = DispatchGroup()
        var isSuccessful = true
        
        //remove all requests
        dg.enter()
        RequestService.clearRequests(for: donation) { (success) in
            if success == false {
                isSuccessful = false
            }
            
            dg.leave()
        }
        
        //delete the donation
        dg.enter()
        let refDonation = Database.database().reference()
            .child("open-donations")
                .child(donation.uid)
        refDonation.setValue(nil) { error, _ in
            if let error = error {
                print("Error deleting donation: \(error.localizedDescription)")
                
                isSuccessful = false
            }
            
            dg.leave()
        }
        
        dg.notify(queue: DispatchQueue.main) {
            completion(isSuccessful)
        }
    }
}
