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
        case one
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
    func addNewRating(_ rating: UserRating) {
        
    }
}
