//
//  KFVInProgressDonationDescription.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 21/09/2018.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import UIKit

class KFVInProgressDonationDescription: KFVDescriptor {
    
    let statusStackView = UIStackView(axis: .vertical)
    let statusTitleLabel = KFLabel(font: UIFont.preferredFont(forTextStyle: .headline), textColor: .kfTitle)
    let statusDescriptionStickyLabel = KFVSticky<UILabel>(stickySide: .top)
    
    let donationDescriptionStackView = UIStackView(axis: .vertical)
    let donationDescriptionTitleLabel = KFLabel(font: UIFont.preferredFont(forTextStyle: .headline), textColor: .kfTitle)
    let donationDescriptionContentLabel = KFLabel(font: UIFont.preferredFont(forTextStyle: .subheadline), textColor: .kfSubtitle)
    
    override func configureLayoutConstraints() {
        super.configureLayoutConstraints()
        
        subtitleStickyLabel.updateStickySide(to: .top)
        subtitleStickyLabel.autoSetDimension(.height, toSize: KFPadding.ContentView)
        
        statusStackView.addArrangedSubview(statusTitleLabel)
        statusStackView.addArrangedSubview(statusDescriptionStickyLabel)
        
        donationDescriptionStackView.addArrangedSubview(donationDescriptionTitleLabel)
        donationDescriptionStackView.addArrangedSubview(donationDescriptionContentLabel)
        
        infoStackView.addArrangedSubview(statusStackView)
        contentsStackView.addArrangedSubview(donationDescriptionStackView)
        
        let _ = imageConstraints.map() { $0.constant = 128 }
    }
    
    override func configureStyling() {
        super.configureStyling()
        
        layer.cornerRadius = 0
        layer.shadowOpacity = 0
        
        statusTitleLabel.text = "Status"
        donationDescriptionTitleLabel.text = "Description"
        subtitleStickyLabel.contentView.text = " "
        
        statusDescriptionStickyLabel.contentView.font = UIFont.preferredFont(forTextStyle: .subheadline)
        statusDescriptionStickyLabel.contentView.textColor = UIColor.kfSubtitle
    }
    
    func reloadData(for data: KFMInProgressDonationDescription) {
        imageView.imageView.kf.setImage(with: data.imageURL)
        
        titleLabel.text = data.title
        
        statusDescriptionStickyLabel.contentView.text = data.statusDescription
        donationDescriptionContentLabel.text = data.description
    }
}


