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
        
//        tabBar.isTranslucent
        tabBar.tintColor = UIColor.kfPrimary
        
        let homeViewController = HomeViewController()
        homeViewController.tabBarItem = UITabBarItem(title: "Home", image: UIImage.kfBoxIcon, tag: 0)
        
        viewControllers = [homeViewController]
        viewControllers = viewControllers?.map { UINavigationController(rootViewController: $0) }
    }


}
