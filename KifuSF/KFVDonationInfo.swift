//
//  KFVDonationInfo.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 07/09/2018.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import UIKit

class KFVDonationInfo: KFVDescriptor {
    let descriptionTextView = KFVSticky<UILabel>(stickySide: .top)
    
    override func setupLayoutConstraints() {
        super.setupLayoutConstraints()
        
        infoStackView.addArrangedSubview(descriptionTextView)
        descriptionTextView.setContentHuggingPriority(.defaultLow, for: .vertical)
    }
    
    override func setUpStyling() {
        super.setUpStyling()
        
        descriptionTextView.contentView.font = UIFont.preferredFont(forTextStyle: .caption2)
        descriptionTextView.contentView.textColor = UIColor.kfBody
        descriptionTextView.contentView.numberOfLines = 2
        descriptionTextView.contentView.adjustsFontForContentSizeCategory = true
        
        //TODO: remove this
        descriptionTextView.contentView.text = "Devices/56F1BA86 -7CB9-4C 2D-BC2 9-804F75 F579D4/data/Containers/Shared/SystemGroupsystemgroup.com.apple.configurationprofiles2018-09-07 22:54:00.966633+0300 KifuSF[42551:1514708] [MC] Reading from private effective user settings."
    }
}
