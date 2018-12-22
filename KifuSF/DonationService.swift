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
    static func createDonation( // swiftlint:disable:this function_parameter_count
        title: String,
        notes: String,
        image: UIImage,
        pickUpAddress: String,
        longitude: Double, latitude: Double, completion: @escaping (Donation?) -> Void) {

        //upload image to storage and get back url
        let donationImageRef = StorageReference.newDonationImageReference()
        StorageService.uploadImage(image, at: donationImageRef) { (url) in
            guard let storageUrl = url else {
                assertionFailure("failed to upload image")
                
                return completion(nil)
            }
            
            //create donation and get dict value
            let newDonationsRef = DatabaseReference.openDonations().childByAutoId()
            
            let donation = Donation(
                uid: newDonationsRef.key!,
                title: title,
                notes: notes,
                imageUrl: storageUrl.absoluteString,
                creationDate: Date(),
                longitude: longitude,
                laditude: latitude,
                pickUpAddress: pickUpAddress,
                donator: User.current,
                status: .open,
                volunteer: nil
            )
            
            let donationDict = donation.dictValue
            
            let fbDg = FirebaseDispatchGroup()
            
            newDonationsRef.updateChildValues(donationDict, withCompletionBlock: fbDg.handleErrorCase)
            
            let donatorRef = DatabaseReference.donation(for: User.current.uid, donation: donation.uid)
            donatorRef.updateChildValues(donationDict, withCompletionBlock: fbDg.handleErrorCase)
            
            fbDg.notify(work: { (isSuccessful) in
                if isSuccessful {
                    completion(donation)
                } else {
                    completion(nil)
                }
            })
        }
    }
    
    static func attach(report: Report, to donation: Donation, completion: @escaping (Bool) -> Void) {
        /**
         FIXME: refactoring open-dontaions: now that the donation can be in multiple locations (open-donations, donator-donation, or volunteer-donation) this is now broken
         */
        
        let refDonation = Database.database().reference().child("open-donations").child(donation.uid)
        let updatedDict: [String: Any] = [
            Donation.Keys.flaggedReportUid: report.uid,
            Donation.Keys.flag: report.flag.rawValue
        ]
        refDonation.updateChildValues(updatedDict) { error, _ in
            if let error = error {
                assertionFailure("there was an error attaching the report: \(error.localizedDescription)")
                return completion(false)
            }
            
            completion(true)
        }
    }

    /**
     update the given donation in the open-donations subtree if the donation.
     
     - ToDo: write a cloud function to update denormalized instances of the given donation
     */
//    static func update(donation: Donation, completion: @escaping (Bool) -> Void) {
//        let refDonation = Database.database().reference().child("open-donations").child(donation.uid)
//        refDonation.updateChildValues(donation.dictValue) { (error, _) in
//            guard error == nil else {
//                assertionFailure(error!.localizedDescription)
//
//                return completion(false)
//            }
//
//            completion(true)
//        }
//    }
    
    static func observeTimelineDonations(completion: @escaping ([Donation]) -> Void) {

        //get donations ref
        let ref = DatabaseReference.openDonations()

        //download snapshot
        ref.observe(.value) { (snapshot) in
            guard let snapshotValue = snapshot.children.allObjects as? [DataSnapshot] else {
                fatalError("could not decode into array") //empty array
            }

            //map snapshot into array of donation
            let openDonations: [Donation] = snapshotValue.compactMap({ (snapshot) -> Donation? in
                guard let donationFromSnapshot = Donation(from: snapshot) else {
                    fatalError("could not decode")
                }

                //only include open donations
                if case .open = donationFromSnapshot.status {

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
    
    static func observeCurrentDonation(completion: @escaping (Donation?) -> Void) {
        let donatorDonationsRef = DatabaseReference.donatorDonations(for: User.current.uid)
        donatorDonationsRef.observe(.value) { (snapshot) in
            
            //TODO: execute in background thread
            guard
                let deliverySnapshot = snapshot.children.allObjects.first as? DataSnapshot else {
                return completion(nil)
            }
            
            guard let donation = Donation(from: deliverySnapshot) else {
                return assertionFailure(KFErrorMessage.failedToDecode)
            }
            
            //TODO: execute in background thread ^^^
            
            completion(donation)
        }
    }
    
    static func observeCurrentDelivery(completion: @escaping (Donation?) -> Void) {
        let volunteerDonationsRef = DatabaseReference.volunteerDonations(for: User.current.uid)
        volunteerDonationsRef.observe(.value) { (snapshot) in
            
            //TODO: execute in background thread
            guard
                let deliverySnapshot = snapshot.children.allObjects.first as? DataSnapshot else {
                return completion(nil)
            }
            
            guard let delivery = Donation(from: deliverySnapshot) else {
                return assertionFailure(KFErrorMessage.failedToDecode)
            }
            
            //TODO: execute in background thread ^^^
            
            completion(delivery)
        }
    }

    static func getNumberOfVolunteers(for donation: Donation, completion: @escaping (Int) -> Void) {
        let ref = DatabaseReference.usersWhoHaveRequested(for: donation.uid)
        
        ref.observe(.value) { (dataSnapshot) in
            let childrenCount = dataSnapshot.childrenCount
            
            completion(Int(childrenCount))
        }
    }
    
    /**
     this sets the donation's state to awaiting pickup and remove all other unaccepted
     requests from the requets sub-tree
     */
    static func accept(volunteer: User, for donation: Donation, completion: @escaping (Bool) -> Void) {
        /**
         - warning: each request is fired independant of one another
         */
        
        var updatedDonation = donation

        //update the status of the donation
        //set the volunteer value of the dontaion to the given user
        let donator = updatedDonation.donator
        updatedDonation.status = .awaitingPickup
        updatedDonation.volunteer = volunteer
        
        var isSuccessful = true
        let dg = DispatchGroup() // swiftlint:disable:this identifier_name
        
        //copy the updated donation in both locations (donator-donations, volunteer-donations)
        let donatorDonationsRef = DatabaseReference.donation(for: donator.uid, donation: donation.uid)
        
        dg.enter()
        donatorDonationsRef.setValue(updatedDonation.dictValue) { (error, _) in
            if let error = error {
                assertionFailure("there was an error \(error.localizedDescription)")
                
                isSuccessful = false
            }
            
            dg.leave()
        }
        
        let volunteerDonationsRef = DatabaseReference.delivery(for: volunteer.uid, donation: donation.uid)
        
        dg.enter()
        volunteerDonationsRef.setValue(updatedDonation.dictValue) { (error, _) in
            if let error = error {
                assertionFailure("there was an error \(error.localizedDescription)")
                
                isSuccessful = false
            }
            
            dg.leave()
        }
        
        //remove the donation from the open-donations
        let openDonationsRef = DatabaseReference.openDonation(donation.uid)
        
        dg.enter()
        openDonationsRef.removeValue { (error, _) in
            if let error = error {
                assertionFailure("there was an error \(error.localizedDescription)")
                
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
        
        //clear other requests the accepted volunteer has made
        dg.enter()
        
        RequestService.clearRequests(for: volunteer) { (success) in
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
    static func confirmPickup(for donation: Donation, completion: @escaping (Bool) -> Void) {
        
        guard let volunteerUid = donation.volunteer?.uid else {
            assertionFailure(KFErrorMessage.inputValidationFailed("donation does not have a volunteer"))
            
            return completion(false)
        }

        var updatedDonation = donation
        updatedDonation.status = .awaitingDelivery
        
        //update only the keys needed to conform to db write rules
        let updatedDict: [String: Any] = [
            Donation.Keys.status: updatedDonation.status.rawValue
        ]
        
        let dg = DispatchGroup() // swiftlint:disable:this identifier_name
        var isSuccessful = true
        
        dg.enter()
        let donatorDonationsRef = DatabaseReference.donation(for: donation.donator.uid, donation: donation.uid)
        donatorDonationsRef.updateChildValues(updatedDict) { (error, _) in
            if let error = error {
                assertionFailure(error.localizedDescription)
                
                isSuccessful = false
            }
            
            dg.leave()
        }
        
        dg.enter()
        let volunteerDonationsRef = DatabaseReference.delivery(for: volunteerUid, donation: donation.uid)
        volunteerDonationsRef.updateChildValues(updatedDict) { (error, _) in
            if let error = error {
                assertionFailure(error.localizedDescription)
                
                isSuccessful = false
            }
            
            dg.leave()
        }

        dg.notify(queue: DispatchQueue.main) {
            completion(isSuccessful)
        }
    }
    
    static func confirmDelivery(for donation: Donation, image: UIImage, completion: @escaping (Bool) -> Void) {
        
        guard let volunteerUid = donation.volunteer?.uid else {
            assertionFailure(KFErrorMessage.inputValidationFailed("donation does not have a volunteer"))
            
            return completion(false)
        }
        
        let imageRef = StorageReference.newDeliveryVerificationImageReference(from: donation)
        
        StorageService.uploadImage(image, at: imageRef) { (downloadURL) in
            guard let downloadURL = downloadURL else {
                assertionFailure("failed to upload")
                
                return completion(false)
            }
            
            var updatedDonation = donation
            updatedDonation.status = .awaitingApproval
            updatedDonation.verificationUrl = downloadURL.absoluteString
            
            let dg = DispatchGroup() // swiftlint:disable:this identifier_name
            var isSuccessful = true
            
            dg.enter()
            
            //update only the keys needed to conform to db write rules
            var updatedDict: [String: Any] = [
                Donation.Keys.status: updatedDonation.status.rawValue,
                Donation.Keys.verificationUrl: updatedDonation.verificationUrl!
            ]
            let donatorDonationsRef = DatabaseReference.donation(for: donation.donator.uid, donation: donation.uid)
            donatorDonationsRef.updateChildValues(updatedDict, withCompletionBlock: { (error, _) in
                if let error = error {
                    assertionFailure(error.localizedDescription)
                    
                    isSuccessful = false
                }
                
                dg.leave()
            })
            
            updatedDict[Donation.Keys.status] = Donation.Status.awaitingReview.rawValue
            
            dg.enter()
            let volunteerDonationsRef = DatabaseReference.delivery(for: volunteerUid, donation: donation.uid)
            volunteerDonationsRef.updateChildValues(updatedDict, withCompletionBlock: { (error, _) in
                if let error = error {
                    assertionFailure(error.localizedDescription)
                    
                    isSuccessful = false
                }
                
                dg.leave()
            })
            
            dg.notify(queue: DispatchQueue.main, execute: {
                completion(isSuccessful)
            })
        }
    }

    static func verifyDelivery(for donation: Donation, completion: @escaping (Bool) -> Void) {
        
        var updatedDonation = donation
        updatedDonation.status = .awaitingReview
        
        //update only the keys needed to conform to db write rules
        let updatedDict: [String: Any] = [
            Donation.Keys.status: updatedDonation.status.rawValue
        ]
        
        let fbDg = FirebaseDispatchGroup() // swiftlint:disable:this identifier_name
        
        let donatorDonationsRef = DatabaseReference.donation(for: donation.donator.uid, donation: donation.uid)
        donatorDonationsRef.updateChildValues(updatedDict, withCompletionBlock: fbDg.handleErrorCase)
        
        fbDg.notify { isSuccessful in
            completion(isSuccessful)
        }
    }

    static func cancel(donation: Donation, completion: @escaping (Bool) -> Void) {
        /**
         FIXME: refactoring open-dontaions: now that the donation can be in multiple locations (open-donations, donator-donation, or volunteer-donation) this is now broken
         */
        
        //remove all requests
        RequestService.clearRequests(for: donation) { (success) in
            guard success else {
                return completion(false)
            }
            
            //delete the donation
            let refDonation = Database.database().reference()
                .child("open-donations")
                    .child(donation.uid)
            refDonation.setValue(nil) { error, _ in
                guard error == nil else {
                    print("Error deleting donation: \(error!.localizedDescription)")
                    
                    return completion(false)
                }
                
                completion(true)
            }
        }
    }
}
