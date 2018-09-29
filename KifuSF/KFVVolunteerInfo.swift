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
    let confirmationStickyButton = KFVSticky<KFVButton>(stickySide: .bottom)
    var indexPath: IndexPath?
    
    weak var delegate: KFPVolunteerInfoCellDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setUpLayoutConstraints() {
        super.setUpLayoutConstraints()
        confirmationStickyButton.translatesAutoresizingMaskIntoConstraints = false
        
        infoStackView.addArrangedSubview(statisticsView)
        infoStackView.addArrangedSubview(confirmationStickyButton)
        
        titleLabel.setContentHuggingPriority(.init(rawValue: 250), for: .vertical)
        subtitleStickyLabel.setContentHuggingPriority(.init(rawValue: 250), for: .vertical)
        statisticsView.setContentHuggingPriority(.init(rawValue: 250), for: .vertical)
        confirmationStickyButton.setContentHuggingPriority(.init(rawValue: 249), for: .vertical)
        
        confirmationStickyButton.autoPinEdge(toSuperviewEdge: .leading)
        confirmationStickyButton.autoPinEdge(toSuperviewEdge: .trailing)
        
        subtitleStickyLabel.updateStickySide()
    }
    
    override func setUpStyling() {
        super.setUpStyling()
        
        confirmationStickyButton.contentView.addTarget(self, action: #selector(confirmationButtonPressed), for: .touchUpInside)
        
//        confirmationStickyButton.contentView.backgroundColor = .kfPrimary
//        confirmationStickyButton.contentView.layer.cornerRadius = CALayer.kfCornerRadius
//        confirmationStickyButton.contentView.showsTouchWhenHighlighted = true
        
        confirmationStickyButton.contentView.setTitle("Confirm", for: .normal)
//        confirmationStickyButton.contentView.titleLabel?.font.withSize(UIFont.buttonFontSize)
//        confirmationStickyButton.contentView.titleLabel?.adjustsFontForContentSizeCategory = true
    }
    
    @objc func confirmationButtonPressed() {
        guard let indexPath = indexPath else {
            fatalError()
        }
        delegate?.didPressButton(for: indexPath)
    }
    
    func reloadData(for data: KFMVolunteerInfo) {
        imageView.imageView.kf.setImage(with: data.imageURL)
        
        titleLabel.text = "@\(data.username)"
        subtitleStickyLabel.contentView.text = "Reputation: \(data.userReputation)%"
        
        statisticsView.donationCountLabel.text = "\(data.userDonationsCount)"
        statisticsView.deliveryCountLabel.text = "\(data.userDeliveriesCount)"
    }
}


protocol KFPVolunteerInfoCellDelegate: class {
    func didPressButton(for indexPath: IndexPath)
}