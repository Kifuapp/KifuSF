//
//  KFVPendingDonation.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 09/09/2018.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import UIKit

class KFVPendingDonation: KFVDescriptor {
    
    let cancelButton = KFVSticky<UIButton>(stickySide: .bottom)
    
    weak var delegate: KFPPendingDonationCellDelegate?
    
    override func setupLayoutConstraints() {
        super.setupLayoutConstraints()
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        
        infoStackView.addArrangedSubview(cancelButton)
        
        titleLabel.setContentHuggingPriority(.init(rawValue: 250), for: .vertical)
        subtitleStickyLabel.setContentHuggingPriority(.init(rawValue: 250), for: .vertical)
        cancelButton.setContentHuggingPriority(.init(rawValue: 249), for: .vertical)
        
        cancelButton.autoPinEdge(toSuperviewEdge: .leading)
        cancelButton.autoPinEdge(toSuperviewEdge: .trailing)
    }
    
    override func setUpStyling() {
        super.setUpStyling()
        
        cancelButton.contentView.addTarget(self, action: #selector(cancelButtonPressed), for: .touchUpInside)
        
        cancelButton.contentView.layer.cornerRadius = CALayer.kfCornerRadius
        cancelButton.contentView.backgroundColor = UIColor.kfDestructive
        cancelButton.contentView.showsTouchWhenHighlighted = true
        
        cancelButton.contentView.setTitle("Cancel", for: .normal)
        cancelButton.contentView.titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        cancelButton.contentView.titleLabel?.adjustsFontForContentSizeCategory = true
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
