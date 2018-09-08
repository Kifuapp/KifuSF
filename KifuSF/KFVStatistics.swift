//
//  KFVStatistics.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 08/09/2018.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import UIKit

class KFVStatistics: UIView {
    let contentStackView = UIStackView()
    
    let deliveryStackView = UIStackView()
    let deliveryImageView = UIImageView()
    let deliveryCountLabel = UILabel()
    
    let donationStackView = UIStackView()
    let donationImageView = UIImageView()
    let donationCountLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(contentStackView)
        
        setUpStyling()
        setupLayoutConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayoutConstraints() {
        deliveryStackView.axis = .horizontal
        deliveryStackView.alignment = .fill
        deliveryStackView.spacing = 4
        
        deliveryStackView.addArrangedSubview(deliveryImageView)
        deliveryStackView.addArrangedSubview(deliveryCountLabel)
        
        donationStackView.axis = .horizontal
        donationStackView.alignment = .fill
        donationStackView.spacing = 4
        
        donationStackView.addArrangedSubview(donationImageView)
        donationStackView.addArrangedSubview(donationCountLabel)
        
        contentStackView.axis = .horizontal
        contentStackView.alignment = .fill
        contentStackView.distribution = .fillEqually
        contentStackView.spacing = 16
        
        contentStackView.addArrangedSubview(deliveryStackView)
        contentStackView.addArrangedSubview(donationStackView)
        
        translatesAutoresizingMaskIntoConstraints = false
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        
        contentStackView.autoPinEdgesToSuperviewEdges()
    }
    
    func setUpStyling() {
        deliveryImageView.image = UIImage.kfDeliveryIcon
        deliveryImageView.contentMode = .scaleAspectFit
        deliveryImageView.adjustsImageSizeForAccessibilityContentSizeCategory = true
        
        deliveryCountLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        deliveryCountLabel.numberOfLines = 1
        deliveryCountLabel.textColor = UIColor.kfBody
        deliveryCountLabel.adjustsFontForContentSizeCategory = true
        
        donationImageView.image = UIImage.kfDonationIcon
        donationImageView.contentMode = .scaleAspectFit
        donationImageView.adjustsImageSizeForAccessibilityContentSizeCategory = true
        
        donationCountLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        donationCountLabel.numberOfLines = 1
        donationCountLabel.textColor = UIColor.kfBody
        donationCountLabel.adjustsFontForContentSizeCategory = true
        
        
        //TODO: remove this
        deliveryCountLabel.text = "12"
        donationCountLabel.text = "12"
    }
    
}
