//
//  DonationTableViewCell.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 27/08/2018.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import UIKit

class DonationTableViewCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var donationImageContainerView: UIView!
    @IBOutlet weak var donationImage: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.clipsToBounds = false
        
        contentView.clipsToBounds = false
        contentView.backgroundColor = UIColor.kfGray
        
        containerView.backgroundColor = UIColor.kfWhite
        containerView.layer.cornerRadius = CALayer.kfCornerRadius
        containerView.layer.setUpShadow()
        
        donationImageContainerView.layer.setUpShadow()
        donationImage.layer.cornerRadius = CALayer.kfCornerRadius
        
        titleLabel.font = UIFont.kfHeader1
        titleLabel.textColor = UIColor.kfHeader1
        
        usernameLabel.font = UIFont.kfSubheader3
        usernameLabel.textColor = UIColor.kfSubheader3
        
        distanceLabel.font = UIFont.kfBody1
        distanceLabel.textColor = UIColor.kfBody1
        
        descriptionLabel.font = UIFont.kfBody2
        descriptionLabel.textColor = UIColor.kfBody2
        descriptionLabel.numberOfLines = 2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
