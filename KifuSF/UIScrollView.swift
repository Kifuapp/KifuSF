//
//  UIScrollView.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 14/10/2018.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import UIKit.UIScrollView

extension UIScrollView {
    func updateBottomPadding(_ padding: CGFloat) {
        scrollIndicatorInsets.bottom = padding
        contentInset.bottom = padding
    }
}
