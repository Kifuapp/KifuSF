//
//  UIWindow.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 16/10/2018.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import UIKit.UIWindow

extension UIWindow {
    func setRootViewController(_ rootViewController: UIViewController) {
        self.rootViewController = rootViewController
        makeKeyAndVisible()
    }
}
