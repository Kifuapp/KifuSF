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
    public static func createRequest(for donation: Donation, completion: @escaping (Bool) -> Void) {
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
     removes the current user, or given userUid, from the given donation in the
     donation-requests and user-requests subtrees

     - Remark: used when the current user cancels their request from the given donation.
     Also, when the given donation clears its requests.
     */
    public static func cancelRequest(for donation: Donation, completion: @escaping (Bool) -> Void) {
        self.cancelRequest(for: donation, forUserUid: User.current.uid, completion: completion)
    }

    /**
     removes the current user, or given userUid, from the given donation in the
     donation-requests and user-requests subtrees

     - Remark: used when the current user cancels their request from the given donation.
     Also, when the given donation clears its requests.
     */
    private static func cancelRequest(
        for donation: Donation,
        forUserUid userUid: String,
        completion: @escaping (Bool) -> Void) {

        //remove donation from user-requests
        let refUserRequest = Database.database().reference()
            .child("user-requests")
                .child(userUid)
                    .child(donation.uid)
        refUserRequest.setValue(nil) { error, _ in
            guard error == nil else {
                print("for user uid \(userUid), there was an error \(error!.localizedDescription)")

                completion(false)
                return
            }

            //remove user from donation-requests
            let refDonationRequests = Database.database().reference()
                .child("donation-requests")
                    .child(donation.uid)
                        .child(userUid)
            refDonationRequests.setValue(nil) { error, _ in
                guard error == nil else {
                    print("there was an error deleting the user requests in the donation-requests \(donation.uid): \(error!.localizedDescription)") // swiftlint:disable:this line_length

                    completion(false)
                    return
                }

                completion(true)
            }
        }
    }

    /**
     removes all requests for the given user from the user-requests. Then, removes
     the given user from the donation-requests

     - Remark: when the given userUid was accepted as a volunteer of a donation
     */
    public static func clearRequests(for user: User, completion: @escaping (Bool) -> Void) {

        //fetch donations from user-requests from the given uid
        self.fetchPendingRequests(for: user) { (donationsToCancel) in

            //for each donation, cancel the request
            let dg = DispatchGroup() // swiftlint:disable:this identifier_name
            var isSuccessful = true

            for aDonation in donationsToCancel {
                dg.enter()
                RequestService.cancelRequest(for: aDonation, forUserUid: user.uid, completion: { (success) in
                    if success == false {
                        isSuccessful = false
                    }

                    dg.leave()
                })
            }

            dg.notify(queue: DispatchQueue.main, execute: {
                completion(isSuccessful)
            })
        }
    }

    /**
     Removes all requets from the given donation from the donation-request sub tree. Then, removes
     the given donation from the user-requests for each user who requested to deliver the donation

     - Remark: when a volunteer is selected or when the donation is canceled
     */
    public static func clearRequests(for donation: Donation, completion: @escaping (Bool) -> Void) {
        /**
         fetches all of the users for the given donation and invokes self.cancelRequest
         for each user that requested to pick up the donation. This will remove
         the given donation from the user's list of donations and the donation's
         list of users.
         */

        //get all users that have requested to deliever in the donation-requests
        let refDonationRequests = Database.database().reference()
            .child("donation-requests")
                .child(donation.uid)
        refDonationRequests.observeSingleEvent(of: .value) { (snapshot) in
            guard let snapshotOfUsers = snapshot.children.allObjects as? [DataSnapshot] else {
                print("failed to convert snapshot into children of snapshots")

                return completion(false)
            }

            //for each user, remove the given donation from user-requests and donation-requests subtrees
            let uidOfRequestedUsers = snapshotOfUsers.map { $0.key }
            let dgRemoveRequests = DispatchGroup()
            var isSuccessful = true

            for aUserUid in uidOfRequestedUsers {
                dgRemoveRequests.enter()
                self.cancelRequest(for: donation, forUserUid: aUserUid, completion: { (successful) in
                    if successful == false {
                        isSuccessful = false
                    }

                    dgRemoveRequests.leave()
                })
            }

            dgRemoveRequests.notify(queue: DispatchQueue.main, execute: {
                completion(isSuccessful)
            })
        }
    }

    /**
     Fetch all the users for the given donation
     */
    public static func retrieveVolunteers(for donation: Donation, completion: @escaping ([User]) -> Void) {
        let ref = Database.database().reference().child("donation-requests").child(donation.uid)
        ref.observeSingleEvent(of: .value) { (snapshot) in
            guard let volunteersSnapshot = snapshot.children.allObjects as? [DataSnapshot] else {
                fatalError("could not decode")
            }

            let volunteers = volunteersSnapshot.compactMap(User.init)
            completion(volunteers)
        }
    }

    /**
     Fetch all donations the user given has reqeusted to deliver
     */
    public static func fetchPendingRequests(for user: User, completion: @escaping ([Donation]) -> Void) {
        let ref = Database.database().reference().child("user-requests").child(user.uid)
        ref.observeSingleEvent(of: .value) { (snapshot) in
            guard let donationSnapshots = snapshot.children.allObjects as? [DataSnapshot] else {
                fatalError("could not decode")
            }

            let requestingDonations = donationSnapshots.compactMap(Donation.init)
            completion(requestingDonations)
        }
    }

    /**
     Observe all donations the user has reqeusted to deliver
     */
    public static func observePendingRequests(completion: @escaping ([Donation]) -> Void) {
        let currentUserUid = User.current.uid
        let ref = Database.database().reference().child("user-requests").child(currentUserUid)
        ref.observe(.value) { (snapshot) in
            guard let donationSnapshots = snapshot.children.allObjects as? [DataSnapshot] else {
                fatalError("could not decode")
            }

            let requestingDonations = donationSnapshots.compactMap(Donation.init)
            completion(requestingDonations)
        }
    }
}
