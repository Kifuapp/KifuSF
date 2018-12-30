//
//  KFVCollaborator.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 28/09/2018.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import UIKit

class CollaboratorDescriptorView: UIDescriptorView {
    //MARK: - Variables
    let headlineLabel = UILabel(font: UIFont.preferredFont(forTextStyle: .headline),
                                textColor: UIColor.Text.Headline)
    let descriptionLabel = UILabel(font: UIFont.preferredFont(forTextStyle: .subheadline),
                                   textColor: UIColor.Text.SubHeadline)
    let statisticsStickyView = UIStickyView<UIStatisticsView>(stickySide: .top)

    //MARK: - Methods
    func reloadData(for data: KFMCollaboratorInfo) {
        imageView.kf.setImage(with: data.profileImageURL)
        titleLabel.text = data.name
        subtitleStickyLabel.contentView.text = "@\(data.username)"
        descriptionLabel.text = "Reputation: \(data.userReputation)%"

        statisticsStickyView.contentView.reloadData(donations: data.userDonationsCount,
                                                    deliveries: data.userDeliveriesCount)
    }

    //MARK: - UIConfigurable
    override func configureLayout() {
        contentsStackView.addArrangedSubview(headlineLabel)
        
        super.configureLayout()
        
        infoStackView.addArrangedSubview(descriptionLabel)
        infoStackView.addArrangedSubview(statisticsStickyView)
        
        titleLabel.setContentHuggingPriority(.init(rawValue: 250), for: .vertical)
        subtitleStickyLabel.setContentHuggingPriority(.init(rawValue: 250), for: .vertical)
        descriptionLabel.setContentHuggingPriority(.init(rawValue: 250), for: .vertical)
        statisticsStickyView.setContentHuggingPriority(.init(rawValue: 249), for: .vertical)
        
        subtitleStickyLabel.updateStickySide()
    }
    
    override func configureStyling() {
        super.configureStyling()
    
        layer.shadowOpacity = 0
        headlineLabel.text = "Collaborator Info"
    }
}
