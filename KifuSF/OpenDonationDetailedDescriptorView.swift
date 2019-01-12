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
    let secondSubtitleStickyLabel = UIStickyView<UILabel>()
    
    let statusStackView = UIStackView()
    let statusTitleLabel = UILabel(font: UIFont.preferredFont(forTextStyle: .headline),
                                   textColor: UIColor.Text.Headline)
    let statusDescription = UILabel(font: UIFont.preferredFont(forTextStyle: .subheadline),
                                    textColor: UIColor.Text.SubHeadline)
    
    let donationDescriptionStackView = UIStackView()
    let donationDescriptionTitleLabel = UILabel(font: UIFont.preferredFont(forTextStyle: .headline),
                                                textColor: UIColor.Text.Headline)
    let donationDescriptionContentLabel = UILabel(font: UIFont.preferredFont(forTextStyle: .subheadline),
                                                  textColor: UIColor.Text.SubHeadline)

    //MARK: - Methods
    func reloadData(for data: KFMOpenDonationDescriptionItem) {
        imageView.kf.setImage(with: data.imageURL)

        titleLabel.text = data.title
        subtitleStickyLabel.contentView.text = "@\(data.username) at \(data.timestamp)"

        secondSubtitleStickyLabel.contentView.text = "Reputation \(data.userReputation)%"

        statisticsStickyView.contentView.reloadData(donations: data.userDonationsCount,
                                                    deliveries: data.userDeliveriesCount)

        statusDescription.text = "\(data.distance)"
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
        infoStackView.addArrangedSubview(secondSubtitleStickyLabel)
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
    }

    private func configureSecondSubtitleStyling() {
        secondSubtitleStickyLabel.contentView.font = UIFont.preferredFont(forTextStyle: .subheadline)
        secondSubtitleStickyLabel.contentView.textColor = UIColor.Text.SubHeadline
        secondSubtitleStickyLabel.contentView.activateDynamicType()
    }

    override func configureData() {
        super.configureData()

        donationDescriptionTitleLabel.text = "Description"
        statusTitleLabel.text = "Distance"
    }
}
