//
//  UniversalExtensions+Firebase.swift
//  KifuSF
//
//  Created by Erick Sanchez on 12/19/18.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import Foundation
import Firebase

extension DatabaseReference {
    static var rootDirectory: DatabaseReference {
        return Database.database().reference()
    }
    
    /**
     `/open-donations`
     */
    static func openDonations() -> DatabaseReference {
        return rootDirectory
            .child("open-donations")
    }
    
    /**
     `/open-donations/:donation_uid`
     */
    static func openDonation(_ donation: String) -> DatabaseReference {
        return openDonations()
            .child(donation)
    }
    
    /**
     `/donator-donations/:user_uid`
     */
    static func donatorDonations(for user: String) -> DatabaseReference {
        return rootDirectory
            .child("donator-donations")
                .child(user)
    }
    
    /**
     `/donator-donations/:user_uid/:donation_uid`
     */
    static func donation(for user: String, donation: String) -> DatabaseReference {
        return donatorDonations(for: user)
            .child(donation)
    }
    
    /**
     `/volunteer-donations/:user_uid`
     */
    static func volunteerDonations(for user: String) -> DatabaseReference {
        return rootDirectory
            .child("volunteer-donations")
                .child(user)
    }
    
    /**
     `/volunteer-donations/:user_uid/:donation`
     */
    static func delivery(for user: String, donation: String) -> DatabaseReference {
        return volunteerDonations(for: user)
            .child(donation)
    }
    
    /**
     `/donation-requests/:donation_uid`
     */
    static func usersWhoHaveRequested(for donation: String) -> DatabaseReference {
        return rootDirectory
            .child("donation-requests")
            .child(donation)
    }
    
    /**
     `/user-requests/:user_uid`
     */
    static func donationsRequested(by user: String) -> DatabaseReference {
        return rootDirectory
            .child("volunteer-requests")
                .child(user)
    }
}

class FirebaseDispatchGroup {
    
    var isSuccessful: Bool {
        return errors.count == 0
    }
    
    private var dispatchGroup: DispatchGroup
    private var errors: [Error] = []
    
    init(_ dispatchGroup: DispatchGroup = DispatchGroup.init()) {
        self.dispatchGroup = dispatchGroup
    }
    
    deinit {
        print("GONE")
    }
    
    var handleErrorCase: (Error?, DatabaseReference) -> Void {
        self.dispatchGroup.enter()
        
        return { error, _ in
            if let error = error {
                assertionFailure(error.localizedDescription)
                
                self.errors.append(error)
            }
            
            self.dispatchGroup.leave()
        }
    }
    
    func notify(_ queue: DispatchQueue = DispatchQueue.main, work: @escaping (Bool) -> Void) {
        dispatchGroup.notify(queue: queue) {
            work(self.isSuccessful)
        }
    }
}

//extension DispatchGroup {
//    func firebaseCallback(flag isSuccessful: inout Bool) -> (Error?, DatabaseReference) -> Void {
//        return { error, _ in
//            if let error = error {
//                assertionFailure("there was an error \(error.localizedDescription)")
//
//                print(isSuccessful)
//            }
//
//            self.leave()
//        }
//    }
//}
