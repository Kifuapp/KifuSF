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
        backgroundColor = UIColor.clear
        
        imageContainerView.layer.setUpShadow()
        imageContainerView.backgroundColor = UIColor.clear
        
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = CALayer.kfCornerRadius
        
        titleLabel.setUp(with: .header1)
        bodyOfTitleLabel.setUp(with: .body1)
        subtitleLabel.setUp(with: .subheader1)
        
        bodyOfSubtitleLabel.setUp(with: .body1)
        bodyOfSubtitleLabel.numberOfLines = 2
        
        descriptionLabel.setUp(with: .subheader1)
        descriptionTextView.setUp(with: .body2, andColor: .clear)
    }
    
}
