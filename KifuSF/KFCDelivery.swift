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
    
    var itemInfo: IndicatorInfo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Delivery"
        view.backgroundColor = UIColor.kfWhite
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: .kfFlagIcon,
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(flagButtonPressed))
    }
    
    @objc func flagButtonPressed() {
        //TODO: flagging
    }
}

extension KFCDelivery: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        guard let info = itemInfo else {
            fatalError("problem")
        }
        
        return info
    }
}
