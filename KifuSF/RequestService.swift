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
    public static func createRequest(for donation: OpenDonation) {
        let ref = Database.database().reference().child("requests").child(donation.uid)
        ref.updateChildValues(User.current.dictValue)
    }
    
    public static func deleteRequests(for donation: OpenDonation) {
        let ref = Database.database().reference().child("requests").child(donation.uid)
        ref.setValue(nil)
    }
}
