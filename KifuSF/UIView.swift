//
//  UIView.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 03/09/2018.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import UIKit.UIView

extension UIView {
    
    static let microInteractionDuration: Double = 0.25
    
    func highlight() {
        backgroundColor = UIColor.kfHighlight
    }
    
    func unhighlight() {
        backgroundColor = UIColor.clear
    }
}
