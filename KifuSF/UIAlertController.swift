//
//  UIAlertController.swift
//  KifuSF
//
//  Created by Erick Sanchez on 7/29/18.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import UIKit

extension UIAlertController {
    convenience init(errorMessage: String?) {
        self.init(
            title: "Oops!",
            message: "Something went wrong" + (errorMessage != nil ? ": \(errorMessage!)" : "."),
            preferredStyle: .alert
        )
        
        let dismissAction = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
        self.addAction(dismissAction)
    }
}
