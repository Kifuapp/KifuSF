//
//  UserService.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 28/07/2018.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import Foundation

import Foundation
import FirebaseAuth.FIRUser
import FirebaseDatabase
import FirebaseStorage
import CoreLocation

typealias FIRUser = FirebaseAuth.User

struct UserService {
    
    public static func create(
        firUser: FIRUser,
        username: String,
        image: UIImage,
        contactNumber: String,
        completion: @escaping (User?) -> Void) {
        let imageRef = StorageReference.newUserImageRefence(with: firUser.uid)
        
        StorageService.uploadImage(image, at: imageRef) { (url) in
            guard let downloadURL = url else { return completion(nil) }
            let imageURL = downloadURL.absoluteString
            
            let newUser = User(
                username: username,
                uid: firUser.uid,
                imageURL: imageURL,
                contributionPoints: 0,
                contactNumber: contactNumber
            )
            
            let ref = Database.database().reference().child("users").child(firUser.uid)
            
            ref.setValue(newUser.dictValue, withCompletionBlock: { (error, _) in
                if error != nil {
                    return completion(nil)
                }
                
                return completion(newUser)
            })
        }
    }
    
    public static func show(forUID uid: String, completion: @escaping (User?) -> Void) {
        let ref = Database.database().reference().child("users").child(uid)
        
        ref.observeSingleEvent(of: .value) { (snapshot) in
            guard let user = User(from: snapshot) else { return completion(nil) }
            
            return completion(user)
        }
    }
    
    /**
     update the given user in the user subtree
     
     - ToDo: write a cloud function to update denormalized instances of the given user
     */
    static func update(user: User, completion: @escaping (Bool) -> Void) {
        let refDonation = Database.database().reference().child("users").child(user.uid)
        refDonation.updateChildValues(user.dictValue) { (error, _) in
            guard error == nil else {
                assertionFailure(error!.localizedDescription)
                
                return completion(false)
            }
            
            completion(true)
        }
    }
    
    public static func calculateDistance(long: Double, lat: Double) -> String {
        let location = CLLocation(latitude: lat, longitude: long)
        if let myCurrentLocation = User.current.currentLocation {
            let distance = myCurrentLocation.distance(from: location) / 1000 * 1.6
            return String(format: "%.2f miles to pickup", arguments: [distance])
        }
        
        return "Distance not available"
    }
}
