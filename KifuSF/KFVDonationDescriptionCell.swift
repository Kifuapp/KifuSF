//
//  KFDonationDescriptionView.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 29/08/2018.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import UIKit

class KFVDonationDescriptionCell: UITableViewCell {

    @IBOutlet weak var donationImageContainerView: UIView!
    @IBOutlet weak var donationImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var reputationLabel: UILabel!
    
    @IBOutlet weak var statisticStackView: UIStackView!
    @IBOutlet weak var deliveryCountLabel: UILabel!
    @IBOutlet weak var donationCountLabel: UILabel!
    
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var bodyOfSubtitleLabel: UILabel!

    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = UIColor.clear
        
        donationImageContainerView.layer.setUpShadow()
        donationImageContainerView.backgroundColor = UIColor.clear

        donationImageView.contentMode = .scaleAspectFill
        donationImageView.layer.cornerRadius = CALayer.kfCornerRadius
        
        titleLabel.setUp(with: .header1)
        usernameLabel.setUp(with: .body1)
        reputationLabel.setUp(with: .body1)
        deliveryCountLabel.setUp(with: .body1)
        donationCountLabel.setUp(with: .body1)
        
        subtitleLabel.setUp(with: .subheader1)
        
        bodyOfSubtitleLabel.setUp(with: .body1)
        bodyOfSubtitleLabel.numberOfLines = 2
        
        descriptionLabel.setUp(with: .subheader1)
//        descriptionTextView.setUp(with: .body2, andColor: .clear)
        descriptionTextView.textColor = #colorLiteral(red: 0.5098039216, green: 0.5098039216, blue: 0.5098039216, alpha: 1)
        
        statisticStackView.heightAnchor.constraint(equalToConstant: deliveryCountLabel.requiredHeight * 1.25).isActive = true
    }
}

extension KFVDonationDescriptionCell: KFPRegistableCell {
    static var nibName = "KFVDonationDescriptionCell"
    static var reuseIdentifier = "donationDescriptionCell"
}
