//
//  DonationTableViewCell.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 27/08/2018.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import UIKit

class KFDonationTableViewCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var donationImageContainerView: UIView!
    @IBOutlet weak var donationImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    static let nibName = "KFDonationTableViewCell"
    static let reuseIdentifier = "donationCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.clipsToBounds = false
        self.selectionStyle = .none
        
        contentView.clipsToBounds = false
        contentView.backgroundColor = UIColor.kfGray
        
        containerView.backgroundColor = UIColor.kfWhite
        containerView.layer.cornerRadius = CALayer.kfCornerRadius
        containerView.layer.setUpShadow()
        
        donationImageContainerView.backgroundColor = UIColor.clear
        donationImageContainerView.layer.setUpShadow()
        
        donationImageView.contentMode = .scaleAspectFill
        donationImageView.layer.cornerRadius = CALayer.kfCornerRadius
        
        titleLabel.setUp(for: .header1)
        usernameLabel.setUp(for: .subheader3)
        distanceLabel.setUp(for: .body1)
        
        descriptionLabel.setUp(for: .body2)
        descriptionLabel.numberOfLines = 2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        containerView?.backgroundColor = selected ? .kfHighlight : .kfWhite
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        
        containerView?.backgroundColor = highlighted ? .kfHighlight : .kfWhite
    }

}
