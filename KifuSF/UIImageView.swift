//
//  UIImageView.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 14/10/2018.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import UIKit.UIImageView

extension UIImageView {
    enum Size: String {
        case small, medium, big

        func get() -> CGFloat {
            switch self {
            case .small:
                return 112
            case .medium:
                return 128
            case .big:
                return 224
            }
        }
    }

    func makeItKifuStyle() {
        layer.cornerRadius = CALayer.kfCornerRadius
        contentMode = .scaleAspectFill
        clipsToBounds = true
    }
}
