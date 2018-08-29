//
//  KFDonationDescriptionView.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 29/08/2018.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import UIKit

class KFDonationDescriptionView: UIView {

    @IBOutlet weak var imageContainerView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyOfTitleLabel: UILabel!
    
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var bodyOfSubtitleLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    static let nibName = "KFDonationDescriptionView"
    
    override func awakeFromNib() {
        imageContainerView.layer.setUpShadow()
        imageContainerView.backgroundColor = UIColor.clear
        
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = CALayer.kfCornerRadius
        
        titleLabel.font = UIFont.kfHeader1
        titleLabel.textColor = UIColor.kfHeader1
        
        bodyOfTitleLabel.font = UIFont.kfBody1
        bodyOfTitleLabel.textColor = UIColor.kfBody1
        
        subtitleLabel.font = UIFont.kfSubheader1
        subtitleLabel.textColor = UIColor.kfSubheader1
        
        bodyOfSubtitleLabel.font = UIFont.kfBody1
        bodyOfSubtitleLabel.textColor = UIColor.kfBody1
        bodyOfSubtitleLabel.numberOfLines = 2
        
        descriptionLabel.font = UIFont.kfSubheader1
        descriptionLabel.textColor = UIColor.kfSubheader1
        
        descriptionTextView.font = UIFont.kfBody2
        descriptionTextView.textColor = UIColor.kfBody2
    }
    
}
