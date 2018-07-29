//
//  User.swift
//  KifuSF
//
//  Created by Erick Sanchez on 7/28/18.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import Foundation
import FirebaseDatabase

struct User {
    
    var dictValue: [String: Any] {
        fatalError()
    }
    
    static var current: User {
        fatalError()
    }
    
    init?(snapshot: DataSnapshot)
}
