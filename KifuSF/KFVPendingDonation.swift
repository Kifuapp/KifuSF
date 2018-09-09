//
//  KFVPendingDonation.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 09/09/2018.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import UIKit

class KDFPendingDonation: KFVDescriptor {
    let cancelButton = KFVSticky<UIButton>()
    
    override func setupLayoutConstraints() {
        super.setupLayoutConstraints()
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        
        infoStackView.addArrangedSubview(cancelButton)
        
        titleLabel.setContentHuggingPriority(.init(rawValue: 250), for: .vertical)
        subtitleLabel.setContentHuggingPriority(.init(rawValue: 250), for: .vertical)
        cancelButton.setContentHuggingPriority(.init(rawValue: 249), for: .vertical)
        
        cancelButton.autoPinEdge(toSuperviewEdge: .leading)
        cancelButton.autoPinEdge(toSuperviewEdge: .trailing)
    }
    
    override func setUpStyling() {
        super.setUpStyling()
        
        cancelButton.contentView.layer.cornerRadius = CALayer.kfCornerRadius
        cancelButton.contentView.backgroundColor = UIColor.kfDestructive
        
        cancelButton.contentView.setTitle("Cancel", for: .normal)
        cancelButton.contentView.titleLabel?.font = UIFont.preferredFont(forTextStyle: .subheadline)
        cancelButton.contentView.titleLabel?.adjustsFontForContentSizeCategory = true
    }
}
