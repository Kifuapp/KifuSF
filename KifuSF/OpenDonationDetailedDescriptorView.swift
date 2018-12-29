//
//  KFVDonationDescription.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 17/09/2018.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import UIKit
import Kingfisher

class OpenDonationDetailedDescriptorView: UIDescriptorView {
    //MARK: - Variables
    private let statisticsStickyView = UIStickyView<UIStatisticsView>(stickySide: .top)
    let secondSubtitleLabel = UIStickyView<UILabel>()
    
    let statusStackView = UIStackView()
    let statusTitleLabel = UILabel()
    let statusDescription = UILabel()
    
    let donationDescriptionStackView = UIStackView()
    let donationDescriptionTitleLabel = UILabel()
    let donationDescriptionContentLabel = UILabel()

    //MARK: - Methods
    func reloadData(for data: KFMOpenDonationDescriptionItem) {
        imageView.kf.setImage(with: data.imageURL)

        titleLabel.text = data.title
        subtitleStickyLabel.contentView.text = "@\(data.username) at \(data.timestamp)"

        secondSubtitleLabel.contentView.text = "Reputation \(data.userReputation)%"

        statisticsStickyView.contentView.reloadData(donations: data.userDonationsCount,
                                                    deliveries: data.userDeliveriesCount)

        statusDescription.text = "\(data.distance) Miles away from your current location"
        donationDescriptionContentLabel.text = data.description
    }

    //MARK: - UIConfigurable
    override func configureLayout() {
        super.configureLayout()

        configureInfoStackViewLayout()
        configureStatusStackViewLayout()
        configureDonationDescriptionStackViewLayout()
        configureContentsStack()

        infoStackView.spacing = 2
        statusStackView.spacing = 2
        donationDescriptionStackView.spacing = 2
        donationDescriptionStackView.axis = .vertical
        
        titleLabel.setContentHuggingPriority(.init(rawValue: 250), for: .vertical)
        subtitleStickyLabel.setContentHuggingPriority(.init(rawValue: 250), for: .vertical)
        statisticsStickyView.setContentHuggingPriority(.init(rawValue: 249), for: .vertical)

        defaultImageViewSize = .medium
        
        subtitleStickyLabel.updateStickySide()
    }

    private func configureInfoStackViewLayout() {
        infoStackView.addArrangedSubview(secondSubtitleLabel)
        infoStackView.addArrangedSubview(statisticsStickyView)
    }

    private func configureStatusStackViewLayout() {
        statusStackView.addArrangedSubview(statusTitleLabel)
        statusStackView.addArrangedSubview(statusDescription)
        statusStackView.axis = .vertical
    }

    private func configureDonationDescriptionStackViewLayout() {
        donationDescriptionStackView.addArrangedSubview(donationDescriptionTitleLabel)
        donationDescriptionStackView.addArrangedSubview(donationDescriptionContentLabel)
    }

    private func configureContentsStack() {
        contentsStackView.addArrangedSubview(statusStackView)
        contentsStackView.addArrangedSubview(donationDescriptionStackView)
    }
    
    override func configureStyling() {
        super.configureStyling()
        
        layer.cornerRadius = 0
        layer.shadowOpacity = 0
        
        configureSecondSubtitleStyling()
        configureStatusTitleLabelStyling()
        configureStatusDescriptionStyling()
        configureDonationDescriptionTitleLabelStyling()
        configureDonationDescriptionTitleLabelStyling()
        configureDonationDescriptionContentLabelStyling()
    }

    private func configureSecondSubtitleStyling() {
        secondSubtitleLabel.contentView.font = UIFont.preferredFont(forTextStyle: .subheadline)
        secondSubtitleLabel.contentView.numberOfLines = 0
        secondSubtitleLabel.contentView.textColor = .kfSubtitle
        secondSubtitleLabel.contentView.adjustsFontForContentSizeCategory = true
    }

    private func configureStatusTitleLabelStyling() {
        statusTitleLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        statusTitleLabel.numberOfLines = 0
        statusTitleLabel.textColor = UIColor.kfTitle
        statusTitleLabel.adjustsFontForContentSizeCategory = true
    }

    private func configureStatusDescriptionStyling() {
        statusDescription.font = UIFont.preferredFont(forTextStyle: .subheadline)
        statusDescription.numberOfLines = 0
        statusDescription.textColor = UIColor.kfSubtitle
        statusDescription.adjustsFontForContentSizeCategory = true
    }

    private func configureDonationDescriptionTitleLabelStyling() {
        donationDescriptionTitleLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        donationDescriptionTitleLabel.numberOfLines = 0
        donationDescriptionTitleLabel.textColor = UIColor.kfTitle
        donationDescriptionTitleLabel.adjustsFontForContentSizeCategory = true
    }

    private func configureDonationDescriptionContentLabelStyling() {
        donationDescriptionContentLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        donationDescriptionContentLabel.numberOfLines = 0
        donationDescriptionContentLabel.textColor = UIColor.kfSubtitle
        donationDescriptionContentLabel.adjustsFontForContentSizeCategory = true
    }

    override func configureData() {
        super.configureData()

        donationDescriptionTitleLabel.text = "Description"
        statusTitleLabel.text = "Distance"
    }
}
