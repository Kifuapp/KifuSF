//
//  KFCDonation.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 19/09/2018.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class KFCDonation: KFCModularTableView {
    
    var itemInfo: IndicatorInfo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.kfWhite
        
    }
}

extension KFCDonation: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Donation")
    }
}
