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

    func scrollToBottom() {
        let yOffset = contentSize.height - bounds.size.height + contentInset.bottom
        if yOffset > 0 {
            let bottomOffset = CGPoint(x: 0, y: yOffset)
            setContentOffset(bottomOffset, animated: true)
        }
    }
}
