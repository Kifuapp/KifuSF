//
//  OnBoardingDistributer.swift
//  KifuSF
//
//  Created by Erick Sanchez on 1/9/19.
//  Copyright © 2019 Alexandru Turcanu. All rights reserved.
//

import UIKit

struct OnBoardingDistributer {
    
    /**
     For the given user, `nextStep(...)` returns either a `UINavigationController`
     with one of the required steps needed to be completed (phone number verified,
     disclaimer accepted, etc.) or if all steps required are completed, this returns
     the HomeTabbar controller
     
     - parameter user: check if .isVerified, .hasApprovedConditions, and
     .hasSeenTutorial
     
     - returns: the view controller needed to be presented (modally) next
     */
    static func nextStep(for user: User) -> UIViewController {
        
        //TODO: tutorial-add user.hasSeenTutorial == false
        
        if user.hasApprovedConditions == false {
            let conditionsVc = KFCLocationServiceDisclaimer()
            
            return UINavigationController(rootViewController: conditionsVc)
        } else if user.isVerified == false {
            let verifyNumberVc = KFCPhoneNumberValidation()
            
            return UINavigationController(rootViewController: verifyNumberVc)
        } else {
            return KifuTabBarViewController()
        }
    }
}
