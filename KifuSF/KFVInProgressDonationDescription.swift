//
//  KFVInProgressDonationDescription.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 21/09/2018.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import UIKit

class KFVInProgressDonationDescription: UIDescriptorView {
    
    let statusStackView = UIStackView(axis: .vertical)
    let statusTitleLabel = UILabel(font: UIFont.preferredFont(forTextStyle: .headline),
                                   textColor: UIColor.Text.Headline)
    let statusDescriptionStickyLabel = UIStickyView<UILabel>(stickySide: .top)
    
    let donationDescriptionStackView = UIStackView(axis: .vertical)
    let donationDescriptionTitleLabel = UILabel(font: UIFont.preferredFont(forTextStyle: .headline),
                                                textColor: UIColor.Text.Headline)
    let donationDescriptionContentLabel = UILabel(font: UIFont.preferredFont(forTextStyle: .subheadline),
                                                  textColor: UIColor.Text.SubHeadline)
    
    override func configureLayout() {
        super.configureLayout()
        
        subtitleStickyLabel.updateStickySide(to: .top)
        subtitleStickyLabel.autoSetDimension(.height, toSize: KFPadding.ContentView)
        
        statusStackView.addArrangedSubview(statusTitleLabel)
        statusStackView.addArrangedSubview(statusDescriptionStickyLabel)
        
        donationDescriptionStackView.addArrangedSubview(donationDescriptionTitleLabel)
        donationDescriptionStackView.addArrangedSubview(donationDescriptionContentLabel)
        
        infoStackView.addArrangedSubview(statusStackView)
        contentsStackView.addArrangedSubview(donationDescriptionStackView)

        defaultImageViewSize = .medium
    }
    
    override func configureStyling() {
        super.configureStyling()
        
        layer.cornerRadius = 0
        layer.shadowOpacity = 0
        
        statusTitleLabel.text = "Status"
        donationDescriptionTitleLabel.text = "Description"
        subtitleStickyLabel.contentView.text = " "
        
        statusDescriptionStickyLabel.contentView.font = UIFont.preferredFont(forTextStyle: .subheadline)
        statusDescriptionStickyLabel.contentView.textColor = UIColor.Text.SubHeadline
        statusDescriptionStickyLabel.contentView.activateDynamicType()
    }
    
    func reloadData(for data: KFMInProgressDonationDescription) {
        imageView.kf.setImage(with: data.imageURL)
        
        titleLabel.text = data.title
        
        statusDescriptionStickyLabel.contentView.text = data.statusDescription
        donationDescriptionContentLabel.text = data.description
    }
}


