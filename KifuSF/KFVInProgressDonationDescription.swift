//
//  KFVInProgressDonationDescription.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 21/09/2018.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import UIKit

class KFVInProgressDonationDescription: KFVDescriptor {
    
    let statusStackView = UIStackView()
    let statusTitleLabel = UILabel()
    let statusDescriptionStickyLabel = KFVSticky<UILabel>(stickySide: .top)
    
    let donationDescriptionStackView = UIStackView()
    let donationDescriptionTitleLabel = UILabel()
    let donationDescriptionContentLabel = UILabel()
    
    override func setupLayoutConstraints() {
        super.setupLayoutConstraints()
        
        subtitleStickyLabel.updateStickySide(to: .top)
        subtitleStickyLabel.contentView.text = " "
        
        infoStackView.spacing = 0
        
        statusStackView.addArrangedSubview(statusTitleLabel)
        statusStackView.addArrangedSubview(statusDescriptionStickyLabel)
        statusStackView.axis = .vertical
        statusStackView.spacing = 2
        
        donationDescriptionStackView.addArrangedSubview(donationDescriptionTitleLabel)
        donationDescriptionStackView.addArrangedSubview(donationDescriptionContentLabel)
        donationDescriptionStackView.axis = .vertical
        donationDescriptionStackView.spacing = 2
        
        infoStackView.addArrangedSubview(statusStackView)
        contentsStackView.addArrangedSubview(donationDescriptionStackView)
        
        
        for constraint in imageConstraints {
            constraint.constant = 128
        }
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        statusStackView.translatesAutoresizingMaskIntoConstraints =  false
        
        subtitleStickyLabel.autoSetDimension(.height, toSize: 8)
    }
    
    override func setUpStyling() {
        super.setUpStyling()
        
        layer.cornerRadius = 0
        layer.shadowOpacity = 0
        
        statusTitleLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        statusTitleLabel.numberOfLines = 0
        statusTitleLabel.textColor = UIColor.kfTitle
        statusTitleLabel.adjustsFontForContentSizeCategory = true
        statusTitleLabel.text = "Status"
        
        statusDescriptionStickyLabel.contentView.font = UIFont.preferredFont(forTextStyle: .subheadline)
        statusDescriptionStickyLabel.contentView.numberOfLines = 0
        statusDescriptionStickyLabel.contentView.textColor = UIColor.kfSubtitle
        statusDescriptionStickyLabel.contentView.adjustsFontForContentSizeCategory = true
        
        donationDescriptionTitleLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        donationDescriptionTitleLabel.numberOfLines = 0
        donationDescriptionTitleLabel.textColor = UIColor.kfTitle
        donationDescriptionTitleLabel.adjustsFontForContentSizeCategory = true
        donationDescriptionTitleLabel.text = "Description"
        
        donationDescriptionContentLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        donationDescriptionContentLabel.numberOfLines = 0
        donationDescriptionContentLabel.textColor = UIColor.kfSubtitle
        donationDescriptionContentLabel.adjustsFontForContentSizeCategory = true
    }
    
    func reloadData(for data: KFMInProgressDonationDescription) {
        imageView.imageView.kf.setImage(with: data.imageURL)
        
        titleLabel.text = data.title
        
        statusDescriptionStickyLabel.contentView.text = data.statusDescription
        donationDescriptionContentLabel.text = data.description
    }
}


