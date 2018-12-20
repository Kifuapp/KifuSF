//
//  UserRating.swift
//  KifuSF
//
//  Created by Erick Sanchez on 12/19/18.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import Foundation

struct UserRating {
    
    enum Stars: Int {
        case one = 1
        case two
        case three
        case four
        case five
    }
    
    // MARK: - VARS
    
    static var oneStar: UserRating {
        return UserRating(rating: .one)
    }
    
    static var twoStar: UserRating {
        return UserRating(rating: .two)
    }
    
    static var threeStar: UserRating {
        return UserRating(rating: .three)
    }
    
    static var fourStar: UserRating {
        return UserRating(rating: .four)
    }
    
    static var fiveStar: UserRating {
        return UserRating(rating: .five)
    }
    
    let rating: Stars
    
    init(rating: Stars) {
        self.rating = rating
    }
    
    init?(numberOfStars: Int) {
        guard let stars = Stars(rawValue: numberOfStars) else {
            return nil
        }
        
        self.rating = stars
    }
    
    // MARK: - RETURN VALUES
    
    // MARK: - METHODS
}

extension User {
    mutating func addNewRating(_ rating: UserRating, increment keyPath: WritableKeyPath<User, Int>) {
        
        //mutate the current user by updating their new reputation
        let nReviews = self.numberOfDeliveries + self.numberOfDonations
        let newStars = rating.rating.rawValue
        self.reputation = (reputation * Float(nReviews) + Float(newStars)) / Float(nReviews + 1)
        
        self[keyPath: keyPath] += 1
    }
}
