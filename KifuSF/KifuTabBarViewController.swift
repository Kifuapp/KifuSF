//
//  KFCTabBar.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 10/09/2018.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import UIKit

class KifuTabBarViewController: UITabBarController {
    //MARK: - Lifecyle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //TODO: check if for location acces
        
        let homeViewController = KFCOpenDonations()
        let settingViewController = SettingsViewController()
        let statusViewController = KFCStatus()
        let leaderboardViewController = KFCLeaderboard()

        homeViewController.tabBarItem = UITabBarItem(
            title: "Home",
            image: .kfBoxIcon,
            tag: 0
        )

        statusViewController.tabBarItem = UITabBarItem(
            title: "Status",
            image: .kfStatusIcon,
            tag: 1
        )

        leaderboardViewController.tabBarItem = UITabBarItem(
            title: "Leaderboard",
            image: .kfLeaderboardIcon,
            tag: 2
        )

        settingViewController.tabBarItem = UITabBarItem(
            title: "Settings",
            image: .kfSettingsIcon,
            tag: 3
        )
        
        viewControllers = [
            homeViewController,
            statusViewController,
            leaderboardViewController,
            settingViewController
        ]

        viewControllers = viewControllers?.map {
            UINavigationController(rootViewController: $0)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidLoad()
        
        // display the tutorial if it hasn't
        if User.current.hasSeenTutorial == false {
            present(TutorialViewController(), animated: true)
            
            UserService.markHasSeenTutorialTrue { (successful) in
                if successful {
                    UserService.updateCurrentUser(key: \.hasSeenTutorial, to: true)
                }
            }
        }
    }
}
