//
//  UIViewController.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 13/10/2018.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import UIKit.UIViewController

extension UIViewController {
    func handleKeyboardActions() {
        
    }
    
    func dismissToRoot(animated: Bool, completion: (() -> Void)? = nil) {
        self.view.window!.rootViewController!.dismiss(animated: animated, completion: completion)
    }
}
