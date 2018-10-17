//
//  UITextField.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 30/08/2018.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//


import UIKit.UITextField

extension UITextField {
    enum ValidatorType {
        case phoneNumber
    }
    
    func setUp(with style: TextStyle) {
        let textStyle = style.retrieve()
        
        self.font = textStyle.font
        self.textColor = textStyle.color
    }
    
    func setUp(with style: TextStyle, andColor color: UIColor) {
        setUp(with: style)
        backgroundColor = color
    }
}
