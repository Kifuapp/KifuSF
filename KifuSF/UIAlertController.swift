//
//  UIAlertController.swift
//  KifuSF
//
//  Created by Erick Sanchez on 7/29/18.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import UIKit

extension UIAlertController {
    convenience init(title: String = "Oops!", errorMessage: String?, dismissTitle: String = "Dismiss") {
        self.init(
            title: title,
            message: "Something went wrong" + (errorMessage != nil ? ": \(errorMessage!)" : "."),
            preferredStyle: .alert
        )
        
        let dismissAction = UIAlertAction(title: dismissTitle, style: .default, handler: nil)
        self.addAction(dismissAction)
    }
    
    
}
