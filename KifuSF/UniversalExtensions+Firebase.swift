//
//  UniversalExtensions+Firebase.swift
//  KifuSF
//
//  Created by Erick Sanchez on 12/19/18.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import Foundation
import FirebaseDatabase

extension DatabaseReference {
    private enum Keys {
        static let openDonations = "open-donations"
        static let volunteerDonations = "volunteer-donations"
        static let donatorDonations = "donator-donations"
        static let users = "users"
        static let donationRequests = "donation-requests"
        static let volunteerRequests = "volunteer-requests"
    }
    
    static var rootDirectory: DatabaseReference {
        return Database.database().reference()
    }
    
//    /**
//     `/users`
//     */
//    static func users() -> DatabaseReference {
//        return rootDirectory
//            .child("users")
//    }
    
    /**
     `/users/:user_uid`
     */
    static func user(at uid: String) -> DatabaseReference {
        return rootDirectory
            .child(Keys.users)
                .child(uid)
    }
    
    /**
     `/users/<current_user>`
     */
    static func currentUser() -> DatabaseReference {
        return user(at: User.current.uid)
    }
    
    /**
     `/open-donations`
     */
    static func openDonations() -> DatabaseReference {
        return rootDirectory
            .child(Keys.openDonations)
    }
    
    /**
     `/open-donations/:donation_uid`
     */
    static func openDonation(at donation: String) -> DatabaseReference {
        return openDonations()
            .child(donation)
    }
    
    /**
     `/donator-donations/:user_uid`
     */
    static func donatorDonations(for user: String) -> DatabaseReference {
        return rootDirectory
            .child(Keys.donatorDonations)
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
            .child(Keys.volunteerDonations)
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
            .child(Keys.donationRequests)
                .child(donation)
    }
    
    /**
     `/user-requests/:user_uid`
     */
    static func donationsRequested(by user: String) -> DatabaseReference {
        return rootDirectory
            .child(Keys.volunteerRequests)
                .child(user)
    }
}

class FirebaseDispatchGroup {
    
    enum Errors: Error {
        case message(String)
        
        var localizedDescription: String {
            switch self {
            case .message(let message):
                return message
            }
        }
    }
    
    // MARK: - VARS
    
    var isSuccessful: Bool {
        return errors.count == 0
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
    
    private var dispatchGroup: DispatchGroup
    private var errors: [Error] = []
    
    init(_ dispatchGroup: DispatchGroup = DispatchGroup.init()) {
        self.dispatchGroup = dispatchGroup
    }
    
    // MARK: - RETURN VALUES
    
    // MARK: - METHODS
    
    func notify(_ queue: DispatchQueue = DispatchQueue.main, work: @escaping (Bool) -> Void) {
        dispatchGroup.notify(queue: queue) {
            work(self.isSuccessful)
        }
    }
    
    func enter() {
        self.dispatchGroup.enter()
    }
    
    func leaveBy(validating successful: Bool, errorMessage: String = #function) {
        if successful == false {
            self.errors.append(Errors.message(errorMessage))
        }
        
        self.dispatchGroup.leave()
    }
    
    func leaveSuccessfully() {
        self.dispatchGroup.leave()
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
