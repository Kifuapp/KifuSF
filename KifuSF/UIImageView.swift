//
//  UIImageView.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 14/10/2018.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import UIKit.UIImageView

extension UIImageView {
    func makeItKifuStyle() {
        layer.cornerRadius = CALayer.kfCornerRadius
        contentMode = .scaleAspectFill
        clipsToBounds = true
    }
}
