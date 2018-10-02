//
//  UIStackView.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 02/10/2018.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import UIKit.UIStackView

extension UIStackView {
    convenience init(axis: NSLayoutConstraint.Axis) {
        self.init()
        
        self.axis = axis
    }
    
    convenience init(axis: NSLayoutConstraint.Axis, alignment: UIStackView.Alignment) {
        self.init(axis: axis)
        
        self.alignment = alignment
    }
    
    convenience init(axis: NSLayoutConstraint.Axis, alignment: UIStackView.Alignment,
                     spacing: CGFloat) {
        self.init(axis: axis, alignment: alignment)
        
        self.spacing = spacing
    }
    
    convenience init(axis: NSLayoutConstraint.Axis, alignment: UIStackView.Alignment,
                     spacing: CGFloat = 0, distribution: UIStackView.Distribution) {
        self.init(axis: axis, alignment: alignment, spacing: spacing)
        
        self.distribution = distribution
    }
}
