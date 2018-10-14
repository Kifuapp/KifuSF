//
//  UILabel.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 29/08/2018.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import UIKit.UILabel

extension UILabel {
    func setUp(with style: TextStyle) {
        let textStyle = style.retrieve()
        
        self.font = textStyle.font
        self.textColor = textStyle.color
    }
    
    public var requiredHeight: CGFloat {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: frame.width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text
        label.attributedText = attributedText
        label.sizeToFit()
        return label.frame.height
    }
    
    convenience init(font: UIFont, textColor: UIColor) {
        self.init()
        
        self.font = font
        self.textColor = textColor
        makeItKifuStyle()
    }

    func makeItKifuStyle() {
        font.withSize(UIFont.buttonFontSize)
        adjustsFontForContentSizeCategory = true
        numberOfLines = 0
    }
    
}
