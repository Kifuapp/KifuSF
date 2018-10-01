//
//  KFCTabBar.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 10/09/2018.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import UIKit

class KFCTabBar: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let homeVC = KFCOpenDonations()
        homeVC.tabBarItem = UITabBarItem(title: "Home", image: .kfBoxIcon, tag: 0)
        
        let statusVC = KFCStatus()
        statusVC.tabBarItem = UITabBarItem(title: "Status", image: .kfBoxIcon, tag: 1)
        
        let leaderboardVC = KFCLeaderboard()
        leaderboardVC.tabBarItem = UITabBarItem(title: "Status", image: .kfBoxIcon, tag: 2)
        
        viewControllers = [homeVC, statusVC, leaderboardVC]
        viewControllers = viewControllers?.map { UINavigationController(rootViewController: $0) }
    }


}
