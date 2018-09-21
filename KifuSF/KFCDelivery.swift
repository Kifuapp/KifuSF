//
//  KFCDelivery.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 07/09/2018.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class KFCDelivery: KFCModularTableView {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.kfWhite
        
    }
    
    override func retrieveProgressItem() -> KFPModularTableViewItem? {
        return KFMProgress()
    }
    
    override func retrieveOpenDonationDescriptionItem() -> KFPModularTableViewItem? {
        return KFMOpenDonationDescriptionItem(imageURL: URL(string: "https://images.pexels.com/photos/356378/pexels-photo-356378.jpeg?auto=compress&cs=tinysrgb&h=350")!, title: "Toilet Paper", username: "Pondorasti", creationDate: "12.12.12", userReputation: 79, userDonationsCount: 12, userDeliveriesCount: 12, distance: 5, description: "woof woof")
    } 
}

extension KFCDelivery: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Delivery")
    }
}
