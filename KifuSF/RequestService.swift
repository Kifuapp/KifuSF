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
    public static func createRequest(for donation: Donation, completion: @escaping (Bool) -> ()) {
        let ref = Database.database().reference().child("requests").child(donation.uid).child(User.current.uid)
        ref.updateChildValues(User.current.dictValue) { error, _ in
            if let error = error {
                print(error)
                
                return completion(false)
            }
            
            completion(true)
        }
    }
    
    public static func deleteRequests(for donation: Donation) {
        let ref = Database.database().reference().child("requests").child(donation.uid)
        ref.setValue(nil)
    }
    
    public static func retrieveVolunteers(for donation: Donation, completion: @escaping ([User]) ->()) {
        let ref = Database.database().reference().child("requests").child(donation.uid)
        ref.observeSingleEvent(of: .value) { (snapshot) in
            guard let volunteersSnapshot = snapshot.children.allObjects as? [DataSnapshot] else {
                fatalError("could not decode")
            }
            
            let volunteers = volunteersSnapshot.compactMap(User.init)
            completion(volunteers)
        }
    }
}
