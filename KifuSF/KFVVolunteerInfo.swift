//
//  KFVVolunteerInfo.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 08/09/2018.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import UIKit

class KFVVolunteerInfo: KFVDescriptor {
    let statisticsView = KFVStatistics()
    
    let confirmationButton = KFVSticky<UIButton>(stickySide: .bottom)
    
    override func setupLayoutConstraints() {
        super.setupLayoutConstraints()
        confirmationButton.translatesAutoresizingMaskIntoConstraints = false
        
        infoStackView.addArrangedSubview(statisticsView)
        infoStackView.addArrangedSubview(confirmationButton)
        
        titleLabel.setContentHuggingPriority(.init(rawValue: 250), for: .vertical)
        subtitleLabel.setContentHuggingPriority(.init(rawValue: 250), for: .vertical)
        statisticsView.setContentHuggingPriority(.init(rawValue: 250), for: .vertical)
        confirmationButton.setContentHuggingPriority(.init(rawValue: 249), for: .vertical)
        
        confirmationButton.autoPinEdge(toSuperviewEdge: .leading)
        confirmationButton.autoPinEdge(toSuperviewEdge: .trailing)
        
        subtitleLabel.updateStickySide()
    }
    
    override func setUpStyling() {
        super.setUpStyling()
        
        confirmationButton.contentView.setTitle("Confirm", for: .normal)
        confirmationButton.contentView.backgroundColor = .kfPrimary
        confirmationButton.contentView.layer.cornerRadius = CALayer.kfCornerRadius
        confirmationButton.contentView.showsTouchWhenHighlighted = true
        
        
        confirmationButton.contentView.titleLabel?.font = UIFont.preferredFont(forTextStyle: .footnote)
        confirmationButton.contentView.titleLabel?.adjustsFontForContentSizeCategory = true

        
        //TODO: remove this
    }
}
