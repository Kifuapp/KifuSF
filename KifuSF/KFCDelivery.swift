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
        return KFMProgress(currentStep: .stepOne, ofType: .delivery)
    }
    
    override func retrieveInProgressDonationDescription() -> KFPModularTableViewItem? {
        return KFMInProgressDonationDescription(imageURL: URL(string: "https://images.pexels.com/photos/356378/pexels-photo-356378.jpeg?auto=compress&cs=tinysrgb&h=350")!, title: "Toilet Paper", statusDescription: "Picking up Item", description: "woof woof")
    }
    
    override func retrieveEntityInfoItem() -> KFPModularTableViewItem? {
        return KFMEntityInfo(name: "Make School", phoneNumber: "+1 (415) 814-0980", address: "1547 Mission St San Francisco, CA  94103", entityType: .charity)
    }
    
    override func retrieveCollaboratorInfoItem() -> KFPModularTableViewItem? {
        return KFMCollaboratorInfo(name: "Alexandru Turcanu", username: "Pondorasti", userReputation: 100.0, userDonationsCount: 99, userDeliveriesCount: 99)
    }
}

extension KFCDelivery: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Delivery")
    }
}
