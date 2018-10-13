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
    
    static let kfStatusIcon: UIImage = {
        guard let image = UIImage(named: "StatusIcon") else {
            fatalError(KFErrorMessage.imageNotFound)
        }
        
        return image
    }()
    
    static let kfLeaderboardIcon: UIImage = {
        guard let image = UIImage(named: "LeaderboardIcon") else {
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
    
    static let kfDeliveryIcon: UIImage = {
        guard let image = UIImage(named: "DeliveryIcon")?.withRenderingMode(.alwaysTemplate) else {
            fatalError(KFErrorMessage.imageNotFound)
        }
        
        return image
    }()
    
    static let kfDonationIcon: UIImage = {
        guard let image = UIImage(named: "DonationIcon")?.withRenderingMode(.alwaysTemplate) else {
            fatalError(KFErrorMessage.imageNotFound)
        }
        
        return image
    }()
    
    static let kfDisclosureIcon: UIImage = {
        guard let image = UIImage(named: "DisclosureIcon")?.withRenderingMode(.alwaysTemplate) else {
            fatalError(KFErrorMessage.imageNotFound)
        }
        
        return image
    }()
    
    static let kfLogo: UIImage = {
        guard let image = UIImage(named: "Logo") else {
            fatalError(KFErrorMessage.imageNotFound)
        }
        
        return image
    }()
}
