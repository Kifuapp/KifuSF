//
//  KFVRequestedDonationCell.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 06/09/2018.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import UIKit

class KFVRequestedDonationCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var donationImageContainerView: UIView!
    @IBOutlet weak var donationImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    
    @IBOutlet weak var cancelButton: UIButton!
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        delegate?.didPressButton()
    }
    
    weak var delegate: KFPRequestedDonationCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.clipsToBounds = false
        self.selectionStyle = .none
        
        contentView.clipsToBounds = false
        contentView.backgroundColor = UIColor.kfGray
        
        containerView.backgroundColor = UIColor.kfWhite
        containerView.layer.cornerRadius = CALayer.kfCornerRadius
        containerView.layer.setUpShadow()
        
        donationImageContainerView.layer.setUpShadow()
        donationImageContainerView.backgroundColor = UIColor.clear
        
        donationImageView.contentMode = .scaleAspectFill
        donationImageView.layer.cornerRadius = CALayer.kfCornerRadius
        
        titleLabel.setUp(with: .header1)
        distanceLabel.setUp(with: .body1)
        
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.setUp(with: .button, andColor: .kfDestructive)
    }
}

protocol KFPRequestedDonationCellDelegate: class {
    func didPressButton()
}

extension KFVRequestedDonationCell: KFPRegistableCell {
    static var nibName: String = "KFVRequestedDonationCell"
    static var reuseIdentifier: String = "requestedDonationCell"
}
