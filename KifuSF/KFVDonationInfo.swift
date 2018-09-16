//
//  KFVDonationInfo.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 07/09/2018.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import UIKit

class KFVDonationInfo: KFVDescriptor {
    let descriptionTextView = KFVSticky<UILabel>(stickySide: .bottom)
    
    override func setupLayoutConstraints() {
        super.setupLayoutConstraints()
        
        infoStackView.addArrangedSubview(descriptionTextView)
    }
    
    override func setUpStyling() {
        super.setUpStyling()
        
        descriptionTextView.contentView.font = UIFont.preferredFont(forTextStyle: .caption1)
        descriptionTextView.contentView.textColor = UIColor.kfBody
        descriptionTextView.contentView.numberOfLines = 2
        descriptionTextView.contentView.adjustsFontForContentSizeCategory = true
        
        //TODO: remove this
        descriptionTextView.contentView.text = "Pick-Up Hours between 10AM - 5PM"
    }
}
