//
//  KFVDonationDescription.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 17/09/2018.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import UIKit

class KFVDonationDescription: KFVDescriptor {
    
    let statisticsView = KFVSticky<KFVStatistics>(stickySide: .top)
    let secondSubtitleLabel = KFVSticky<UILabel>()
    
    override func setupLayoutConstraints() {
        super.setupLayoutConstraints()
        
        infoStackView.addArrangedSubview(secondSubtitleLabel)
        infoStackView.addArrangedSubview(statisticsView)
        
        titleLabel.setContentHuggingPriority(.init(rawValue: 250), for: .vertical)
        subtitleLabel.setContentHuggingPriority(.init(rawValue: 250), for: .vertical)
        statisticsView.setContentHuggingPriority(.init(rawValue: 250), for: .vertical)
        statisticsView.setContentHuggingPriority(.init(rawValue: 249), for: .vertical)
        
        for constraint in imageConstraints {
            constraint.constant = 128
        }
        
        subtitleLabel.updateStickySide()
    }
    
    override func setUpStyling() {
        super.setUpStyling()
        
        layer.cornerRadius = 0
        layer.shadowOpacity = 0
        
        secondSubtitleLabel.contentView.font = UIFont.preferredFont(forTextStyle: .subheadline)
        secondSubtitleLabel.contentView.numberOfLines = 0
        secondSubtitleLabel.contentView.textColor = UIColor.kfSubtitle
        secondSubtitleLabel.contentView.adjustsFontForContentSizeCategory = true
        
        //TODO: remove this
        secondSubtitleLabel.contentView.text = "Reputation: 70%"
    }
    
    func update(for data: KFVMDonationDescriptionItem) {
        secondSubtitleLabel.contentView.text = "Reputation: \(data.userReputation)%"
    }
}

class KFVMDonationDescriptionItem: KFPModularTableViewItem {
    var type: KFCModularTableView.CellTypes = .donationDescription
    
    var donationTitle: String
    var username: String
    var creationDate: String
    
    var userReputation: Double
    var userDonationsCount: Int
    var userDeliveriesCount: Int
    
    var distance: Double
    
    var description: String
    
    init(donationTitle: String, username: String, creationDate: String,
         userReputation: Double, userDonationsCount: Int, userDeliveriesCount: Int,
         distance: Double, description: String) {
        
        self.donationTitle = donationTitle
        self.username = username
        self.creationDate = creationDate
        
        self.userReputation = userReputation
        self.userDonationsCount = userDonationsCount
        self.userDeliveriesCount = userDeliveriesCount
        
        self.distance = distance
        self.description = description
    }
}


