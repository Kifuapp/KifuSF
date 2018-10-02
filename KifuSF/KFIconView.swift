//
//  KFIconView.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 02/10/2018.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import UIKit

class KFIconView: UIImageView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience override init(image: UIImage?) {
        self.init(frame: CGRect.zero)
        
        self.image = image
        contentMode = .scaleAspectFit
        adjustsImageSizeForAccessibilityContentSizeCategory = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
