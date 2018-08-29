//
//  UILabel.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 29/08/2018.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {
    func setUp(for style: TextStyle) {
        let textStyle = style.retrieve()
        
        self.font = textStyle.font
        self.textColor = textStyle.color
    }
}
