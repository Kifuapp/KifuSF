//
//  UITextView.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 29/08/2018.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import UIKit.UITextView

extension UITextView {
    convenience init(font: UIFont, textColor: UIColor) {
        self.init()

        self.font = font
        self.textColor = textColor
        activateDynamicType()
    }

    func activateDynamicType() {
        adjustsFontForContentSizeCategory = true
    }
}
