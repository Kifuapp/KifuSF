//
//  KFLabel.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 02/10/2018.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import UIKit

class KFLabel: UILabel {

    convenience init() {
        self.init(frame: CGRect.zero)
    }
    
    convenience init(font: UIFont, textColor: UIColor) {
        self.init()
        
        self.font = font
        self.textColor = textColor
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        font.withSize(UIFont.buttonFontSize)
        adjustsFontForContentSizeCategory = true
        numberOfLines = 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
