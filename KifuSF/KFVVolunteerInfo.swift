//
//  KFVVolunteerInfo.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 08/09/2018.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import UIKit

class KFVVolunteerInfo: DescriptorView {

    let statisticsView = KFVStatistics()
    let confirmationStickyButton = KFVSticky<KFButton>(stickySide: .bottom)
    var indexPath: IndexPath?

    weak var delegate: KFPVolunteerInfoCellDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func configureLayout() {
        super.configureLayout()
        confirmationStickyButton.translatesAutoresizingMaskIntoConstraints = false

        infoStackView.addArrangedSubview(statisticsView)
        infoStackView.addArrangedSubview(confirmationStickyButton)

        titleLabel.setContentHuggingPriority(.init(rawValue: 250), for: .vertical)
        subtitleStickyLabel.setContentHuggingPriority(.init(rawValue: 250), for: .vertical)
        statisticsView.setContentHuggingPriority(.init(rawValue: 250), for: .vertical)
        confirmationStickyButton.setContentHuggingPriority(.init(rawValue: 249), for: .vertical)

        confirmationStickyButton.autoPinEdge(toSuperviewEdge: .leading)
        confirmationStickyButton.autoPinEdge(toSuperviewEdge: .trailing)
        confirmationStickyButton.contentView.heightConstraint.isActive = false

        subtitleStickyLabel.updateStickySide()
    }

    override func configureStyling() {
        super.configureStyling()

        confirmationStickyButton.contentView.addTarget(self, action: #selector(confirmationButtonPressed), for: .touchUpInside)
        confirmationStickyButton.contentView.setTitle("Confirm", for: .normal)
    }

    @objc func confirmationButtonPressed() {
        guard let tableViewCell = superview?.superview as? KFVRoundedCell<KFVVolunteerInfo> else {
            fatalError("you are using this view the wrong way :]")
        }

        delegate?.didPressButton(tableViewCell)
    }

    func reloadData(for data: KFMVolunteerInfo) {
        imageView.kf.setImage(with: data.imageURL)
        
        titleLabel.text = "@\(data.username)"
        subtitleStickyLabel.contentView.text = "Reputation: \(data.userReputation)%"

        statisticsView.donationCountLabel.text = "\(data.userDonationsCount)"
        statisticsView.deliveryCountLabel.text = "\(data.userDeliveriesCount)"
    }
}


protocol KFPVolunteerInfoCellDelegate: class {
    func didPressButton(_ sender: KFVRoundedCell<KFVVolunteerInfo>)
}
