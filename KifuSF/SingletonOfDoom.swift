//
//  SingletonOfDoom.swift
//  KifuSF
//
//  Created by Erick Sanchez on 7/28/18.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import Foundation

class SingletoneBadClassForUserStuff {
    static var sharedInstanceOfBadness = SingletoneBadClassForUserStuff()
    
    var openDonation: OpenDonation?
    var openDelivery: OpenDonation?
}
