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
     For the current user, the given viewController will either be presenting the
     required steps needed to be completed (phone number verified, disclaimer accepted,
     etc.) or if all steps required are completed, this presents the HomeTabbar controller
     
     - parameter viewController: presents the next step or the home tab bar
     
     - precondition: requires the current user to be set and updated if mutated
    */
    static func presentNextStepIfNeeded(from viewController: UIViewController) {
        let user = User.current
        
        if user.hasApprovedConditions == false {
            let conditionsVc = KFCLocationServiceDisclaimer()
            viewController.present(UINavigationController(rootViewController: conditionsVc), animated: true)
        } else if user.isVerified == false {
            let verifyNumberVc = KFCPhoneNumberValidation()
            viewController.present(UINavigationController(rootViewController: verifyNumberVc), animated: true)
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
    
    /**
     either presents the HomeTabBar (if the window.root = FrontPageVc), or dismisses
     to the HomeTabBar (if the window.root = HomeTabBar)
     
     - warning: presenting the home page must require the window to have a root view controller
     */
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
