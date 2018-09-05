//
//  UIView.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 03/09/2018.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import UIKit.UIView

extension UIView {
    func highlight() {
        backgroundColor = UIColor.kfHighlight
    }
    
    func unhighlight() {
        backgroundColor = UIColor.clear
    }
}
