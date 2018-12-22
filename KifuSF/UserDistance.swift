//
//  UserDistance.swift
//  KifuSF
//
//  Created by Erick Sanchez on 12/22/18.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import Foundation

enum UserDistance: CustomStringConvertible {
    case available(String)
    case notAvailable
    
    var isAvailable: Bool {
        switch self {
        case .available:
            return true
        default:
            return false
        }
    }
    
    /** returns a user friendly string of the user's location */
    var description: String {
        switch self {
        case .available(let miles):
            return "\(miles) miles away"
        default:
            return "Distance is not available"
        }
    }
}
