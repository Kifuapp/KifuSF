//
//  KFVDonationInfo.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 07/09/2018.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import UIKit

class KFVDonationInfo: KFVDescriptor {
    let descriptionTextView = KFVSticky<UILabel>(stickySide: .top, withOffset: 8)
    
    override func setupLayoutConstraints() {
        super.setupLayoutConstraints()
        
        infoStackView.addArrangedSubview(descriptionTextView)
    }
    
    override func setUpStyling() {
        super.setUpStyling()
        
        descriptionTextView.contentView.font = UIFont.preferredFont(forTextStyle: .subheadline)
        descriptionTextView.contentView.textColor = UIColor.kfBody
        descriptionTextView.contentView.numberOfLines = 2
        descriptionTextView.contentView.adjustsFontForContentSizeCategory = true
    }
    
    func reloadData(for data: KFMDonationInfo) {
        imageView.imageView.kf.setImage(with: data.imageURL)
        titleLabel.text = data.title
        subtitleStickyLabel.contentView.text = "\(data.distance) Miles away"
        descriptionTextView.contentView.text = data.description
    }
}
