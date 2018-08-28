//
//  KFWidgetView.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 28/08/2018.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import UIKit

class KFWidgetView: UIView {

    @IBOutlet weak var deliveryStackView: UIStackView!
    @IBOutlet weak var donationStackView: UIStackView!
    
    @IBOutlet weak var deliveryTitleLabel: UILabel!
    @IBOutlet weak var deliverySubtitleLabel: UILabel!
    
    @IBOutlet weak var deliveryDisclosureImageView: UIImageView!
    
    @IBOutlet weak var donationTitleLabel: UILabel!
    @IBOutlet weak var donationSubtitleLabel: UILabel!
    
    @IBOutlet weak var donationDisclosureImageView: UIImageView!
    
    static let nibName = "KFWidgetView"
    
    var dataSource: KFWidgetViewDataSource?
    var delegate: KFWidgetViewDelegate?
    
    override func awakeFromNib() {
        deliveryTitleLabel.font = UIFont.kfBody1
        deliveryTitleLabel.textColor = UIColor.kfBody1
        
        deliverySubtitleLabel.font = UIFont.kfHeader2
        deliverySubtitleLabel.textColor = UIColor.kfHeader2
        
        donationTitleLabel.font = UIFont.kfBody1
        donationTitleLabel.textColor = UIColor.kfBody1
        
        donationSubtitleLabel.font = UIFont.kfHeader2
        donationSubtitleLabel.textColor = UIColor.kfHeader2
        
        deliveryDisclosureImageView.tintColor = UIColor.kfPrimary
        donationDisclosureImageView.tintColor = UIColor.kfPrimary
        
    }

}

protocol KFWidgetViewDataSource {
    
    
}

protocol KFWidgetViewDelegate {
    
}
