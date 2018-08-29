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
        
        deliveryTitleLabel.setUp(for: .body1)
        deliverySubtitleLabel.setUp(for: .header2)
        donationTitleLabel.setUp(for: .body1)
        donationSubtitleLabel.setUp(for: .header2)
        
        deliveryDisclosureImageView.tintColor = UIColor.kfPrimary
        donationDisclosureImageView.tintColor = UIColor.kfPrimary
    }

}

protocol KFWidgetViewDataSource {
    
    
}

protocol KFWidgetViewDelegate {
    
}
