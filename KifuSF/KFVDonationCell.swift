//
//  DonationTableViewCell.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 27/08/2018.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import UIKit
import PureLayout

class KFVDonationCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var donationImageContainerView: UIView!
    @IBOutlet weak var donationImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    let descriptorView = KFVVolunteerInfo()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(descriptorView)
        
        translatesAutoresizingMaskIntoConstraints = false
        descriptorView.translatesAutoresizingMaskIntoConstraints = false
        
        descriptorView.autoPinEdge(toSuperviewEdge: .top, withInset: 8)
        descriptorView.autoPinEdge(toSuperviewEdge: .leading, withInset: 24)
        descriptorView.autoPinEdge(toSuperviewEdge: .trailing, withInset: 24)
        descriptorView.autoPinEdge(toSuperviewEdge: .bottom, withInset: 8)
        
        self.selectionStyle = .none
        layer.masksToBounds = false
        contentView.backgroundColor = UIColor.kfGray
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        descriptorView.backgroundColor = selected ? .kfHighlight : .kfWhite
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        
        descriptorView.backgroundColor = highlighted ? .kfHighlight : .kfWhite
    }
}

extension KFVDonationCell: KFPRegistableCell {
    static var reuseIdentifier = "donationCell"
    static var nibName = "KFVDonationCell"
}


