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
//    static func nextStep(for user: User) -> UIViewController {
//
//        //TODO: tutorial-add user.hasSeenTutorial == false
//
//        if user.hasApprovedConditions == false {
//            let conditionsVc = KFCLocationServiceDisclaimer()
//
//            return UINavigationController(rootViewController: conditionsVc)
//        } else if user.isVerified == false {
//            let verifyNumberVc = KFCPhoneNumberValidation()
//
//            return UINavigationController(rootViewController: verifyNumberVc)
//        } else {
//            let tabBarVc = KifuTabBarViewController()
//            tabBarVc.modalTransitionStyle = .flipHorizontal
//
//            return tabBarVc
//        }
//    }
    
    /**
     For the given user, `nextStep(...)` returns either a `UINavigationController`
     with one of the required steps needed to be completed (phone number verified,
     disclaimer accepted, etc.) or if all steps required are completed, this returns
     the HomeTabbar controller
     
     - parameter user: check if .isVerified, .hasApprovedConditions, and
     .hasSeenTutorial
     
     - precondition: requires the current user to be set and updated if mutated
     
     - returns: the view controller needed to be presented (modally) next
     */
    static func presentNextStepIfNeeded(from viewController: UIViewController) {
        let user = User.current
        
        if user.hasApprovedConditions == false {
            let conditionsVc = KFCLocationServiceDisclaimer()
            viewController.present(conditionsVc, animated: true)
        } else if user.isVerified == false {
            let verifyNumberVc = KFCPhoneNumberValidation()
            viewController.present(verifyNumberVc, animated: true)
        } else {
            
            // persist the user in User Defaults
            User.writeToPersistance()
            
            presentHomePage(from: viewController)
        }
    }
    
    /**
     either presents the FrontPageVc (if the window.root = TabBar), or dismisses
     to the FrontPageVc (if the window.root = FrontPageVc)
     
     - warning: presenting the frontpage controller must occur from the home tab
     bar controller
     */
    static func presentFrontPage(from viewController: UIViewController) {
        guard let tabBarController = viewController.tabBarController else {
            fatalError("presenting the frontpage controller must occur from the home tab bar controller")
        }
        
        if tabBarController.presentingViewController != nil {
            viewController.dismissToRoot(animated: true)
        } else {
            tabBarController.present(
                UINavigationController(rootViewController: FrontPageViewController()),
                animated: true
            )
        }
    }
    
    static func presentHomePage(from viewController: UIViewController) {
        guard let rootVc = AppDelegate.shared.window?.rootViewController else {
            fatalError("no root view controller")
        }
        
        if let tabBar = rootVc as? KifuTabBarViewController {
            tabBar.selectedIndex = 0
            viewController.dismissToRoot(animated: true)
        } else {
            let homeTabBar = KifuTabBarViewController()
            homeTabBar.modalTransitionStyle = .flipHorizontal
            
            viewController.present(homeTabBar, animated: true)
        }
    }
}
