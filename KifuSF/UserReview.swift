//
//  UserReview.swift
//  KifuSF
//
//  Created by Erick Sanchez on 12/19/18.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import Foundation

struct UserReview {
    
    enum Stars: Int {
        case one = 1
        case two
        case three
        case four
        case five
    }
    
    // MARK: - VARS
    
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
