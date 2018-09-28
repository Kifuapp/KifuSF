//
//  KFVPendingDonation.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 09/09/2018.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import UIKit

class KFVPendingDonation: KFVDescriptor {
    
    let cancelStickyButton = KFVSticky<UIButton>(stickySide: .bottom)
    
    weak var delegate: KFPPendingDonationCellDelegate?
    
    override func setUpLayoutConstraints() {
        super.setUpLayoutConstraints()
        cancelStickyButton.translatesAutoresizingMaskIntoConstraints = false
        
        infoStackView.addArrangedSubview(cancelStickyButton)
        
        titleLabel.setContentHuggingPriority(.init(rawValue: 250), for: .vertical)
        subtitleStickyLabel.setContentHuggingPriority(.init(rawValue: 250), for: .vertical)
        cancelStickyButton.setContentHuggingPriority(.init(rawValue: 249), for: .vertical)
        
        cancelStickyButton.autoPinEdge(toSuperviewEdge: .leading)
        cancelStickyButton.autoPinEdge(toSuperviewEdge: .trailing)
    }
    
    override func setUpStyling() {
        super.setUpStyling()
        
        cancelStickyButton.contentView.addTarget(self, action: #selector(cancelButtonPressed), for: .touchUpInside)
        
        cancelStickyButton.contentView.layer.cornerRadius = CALayer.kfCornerRadius
        cancelStickyButton.contentView.backgroundColor = UIColor.kfDestructive
        cancelStickyButton.contentView.showsTouchWhenHighlighted = true
        
        cancelStickyButton.contentView.setTitle("Cancel", for: .normal)
        cancelStickyButton.contentView.titleLabel?.font.withSize(UIFont.buttonFontSize)
        cancelStickyButton.contentView.titleLabel?.adjustsFontForContentSizeCategory = true
    }
    
    @objc func cancelButtonPressed() {
        delegate?.didPressButton()
    }
    
    func reloadData(for data: KFMPendingDonation) {
        imageView.imageView.kf.setImage(with: data.imageURL)
        
        titleLabel.text = data.title
        subtitleStickyLabel.contentView.text = "\(data.distance) Miles away"
    }
}

protocol KFPPendingDonationCellDelegate: class {
    func didPressButton()
}
