//
//  OnBoardingDistributer.swift
//  KifuSF
//
//  Created by Erick Sanchez on 1/9/19.
//  Copyright © 2019 Alexandru Turcanu. All rights reserved.
//

import UIKit

struct OnBoardingDistributer {
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
