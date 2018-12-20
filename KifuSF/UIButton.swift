//
//  UIButton.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 30/08/2018.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import UIKit.UIButton

extension UIButton {
    
    func setUp(with style: TextStyle, andColor color: UIColor) {
        let textStyle = style.retrieve()
        
        backgroundColor = color
        layer.cornerRadius = CALayer.kfCornerRadius
        
        setTitleColor(textStyle.color, for: .normal)
        titleLabel?.font = textStyle.font
    }
    
    func setTitle(_ title: String, with style: TextStyle) {
        let textStyle = style.retrieve()
        
        let attributedString = NSAttributedString(string: title,
                                                  attributes: [NSAttributedStringKey.font: textStyle.font])
        setAttributedTitle(attributedString, for: .normal)
        
        tintColor = textStyle.color
    }
    
    func showLoadingIndicator(_ shouldShow: Bool) {
        let tag = 9876
        
        if shouldShow {
            let indicator = UIActivityIndicatorView()
            let buttonHeight = self.bounds.size.height
            let buttonWidth = self.bounds.size.width
            indicator.center = CGPoint(x: buttonWidth / 2, y: buttonHeight / 2)
            
            indicator.tag = tag
            self.addSubview(indicator)
            indicator.startAnimating()
        } else {
            if let indicator = self.viewWithTag(tag) as? UIActivityIndicatorView {
                indicator.stopAnimating()
                indicator.removeFromSuperview()
            }
        }
    }
}
