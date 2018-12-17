//
//  KFVDonationInfo.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 07/09/2018.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import UIKit

class KFVDonationInfo: UIDescriptorView {
    let descriptionStickyTextView = KFVSticky<UILabel>(stickySide: .top, withOffset: 8)
    
    override func configureLayout() {
        super.configureLayout()
        
        infoStackView.addArrangedSubview(descriptionStickyTextView)
    }
    
     override func configureStyling() {
        super.configureStyling()
        
        descriptionStickyTextView.contentView.font = UIFont.preferredFont(forTextStyle: .subheadline)
        descriptionStickyTextView.contentView.textColor = UIColor.kfBody
        descriptionStickyTextView.contentView.numberOfLines = 2
        descriptionStickyTextView.contentView.adjustsFontForContentSizeCategory = true
    }
    
    
    func reloadData(for data: KFMDonationInfo) {
        imageView.kf.setImage(with: data.imageURL)
        titleLabel.text = data.title
        subtitleStickyLabel.contentView.text = "\(data.distance) Miles away"
        descriptionStickyTextView.contentView.text = data.description
    }
}

