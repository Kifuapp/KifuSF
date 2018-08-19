//
//  RequestService.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 28/07/2018.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import Foundation
import FirebaseDatabase

struct RequestService {
    
    /**
     Creates a donation request for the given donation and creates a user request for the current user
     */
    public static func createRequest(for donation: Donation, completion: @escaping (Bool) -> ()) {
        let currentUserUid = User.current.uid
        let refDonationRequests = Database.database().reference()
            .child("donation-requests")
                .child(donation.uid)
                    .child(currentUserUid)
        refDonationRequests.updateChildValues(User.current.dictValue) { error, _ in
            if let error = error {
                print(error)
                
                return completion(false)
            }
            
            let refUserRequests = Database.database().reference()
                .child("user-requests")
                    .child(currentUserUid)
                        .child(donation.uid)
            refUserRequests.setValue(donation.dictValue) { error, _ in
                if let error = error {
                    print(error.localizedDescription)
                    
                    return completion(false)
                }
                
                completion(true)
            }
        }
    }
    
    /**
     removes the current user from the donation-requests and user-requests subtrees
     for the given donation
     */
    public static func cancelRequest(for donation: Donation, completion: @escaping (Bool) -> Void) {
        
    }
    
    /**
     Removes all users from the donation-request sub tree and removes the donation from all user's user-request
     */
    public static func clearRequests(for donation: Donation, completion: @escaping (Bool) -> Void) {
        
        //get all users that have requested to deliever
        let refDonationRequests = Database.database().reference()
            .child("donation-requests")
                .child(donation.uid)
        refDonationRequests.observeSingleEvent(of: .value) { (snapshot) in
            guard let snapshotOfUsers = snapshot.children.allObjects as? [DataSnapshot] else {
                print("failed to convert snapshot into children of snapshots")
                
                return completion(false)
            }
            
            //for each user, remove the given donation from its list of requests
            let uidOfRequestedUsers = snapshotOfUsers.map { $0.key }
            let dgRemoveDonationFromUserRequests = DispatchGroup()
            var isSuccessful = true
            
            for aUserUid in uidOfRequestedUsers {
                dgRemoveDonationFromUserRequests.enter()
                let refUserRequest = Database.database().reference()
                    .child("user-requests")
                        .child(aUserUid)
                            .child(donation.uid)
                refUserRequest.setValue(nil) { error, _ in
                    if let error = error {
                        print("for user uid \(aUserUid), there was an error \(error.localizedDescription)")
                        
                        isSuccessful = false
                    }
                    
                    dgRemoveDonationFromUserRequests.leave()
                }
            }
            
            //remove the users from the donation-requests subtree
            dgRemoveDonationFromUserRequests.enter()
            
            refDonationRequests.setValue(nil) { error, _ in
                if let error = error {
                    print("there was an error deleting the user requests in the donation-requests \(donation.uid): \(error.localizedDescription)")
                    
                    isSuccessful = false
                }
                
                dgRemoveDonationFromUserRequests.leave()
            }
            
            dgRemoveDonationFromUserRequests.notify(queue: DispatchQueue.main, execute: {
                completion(isSuccessful)
            })
        }
    }
    
    /**
     Fetch all the users for the given donation
     */
    public static func retrieveVolunteers(for donation: Donation, completion: @escaping ([User]) ->()) {
        let ref = Database.database().reference().child("donation-requests").child(donation.uid)
        ref.observeSingleEvent(of: .value) { (snapshot) in
            guard let volunteersSnapshot = snapshot.children.allObjects as? [DataSnapshot] else {
                fatalError("could not decode")
            }
            
            let volunteers = volunteersSnapshot.compactMap(User.init)
            completion(volunteers)
        }
    }
}
