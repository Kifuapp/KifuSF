//
//  UIImage.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 06/09/2018.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import UIKit.UIImage

extension UIImage {
    static let kfFlagIcon: UIImage = {
        guard let image = UIImage(named: "FlagIcon") else {
            fatalError(KFErrorMessage.imageNotFound)
        }
        
        return image
    }()
    
    static let kfBoxIcon: UIImage = {
        guard let image = UIImage(named: "BoxIcon") else {
            fatalError(KFErrorMessage.imageNotFound)
        }
        
        return image
    }()
    
    static let kfPlusIcon: UIImage = {
        guard let image = UIImage(named: "PlusIcon") else {
            fatalError(KFErrorMessage.imageNotFound)
        }
        
        return image
    }()
}
