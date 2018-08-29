//
//  Constants.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 28/07/2018.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import Foundation
import UIKit

struct KFUserInterface {
    struct tabBarTitle {
        static let indexOne: String = "Home"
        static let indexTwo: String = "Status"
        static let indexThree: String = "Social"
    }
}

struct KFSegue {
    static let showDetailedDonation = "showDetailedDonation"
}

struct KFErrorMessage {
    static let unknownCell = "unknown donation table view cell"
    static let imageNotFound = "could not load image"
    static let nibFileNotFound = "could not load nib file"
    static let textStyleNotFount = "could not load text style"
}

struct KFImage {
    static let flagIcon: UIImage = {
        guard let image = UIImage(named: "FlagIcon") else {
            fatalError(KFErrorMessage.imageNotFound)
        }
        
        return image
    }()
    
    static let boxIcon: UIImage = {
        guard let image = UIImage(named: "BoxIcon") else {
            fatalError(KFErrorMessage.imageNotFound)
        }
        
        return image
    }()
}

