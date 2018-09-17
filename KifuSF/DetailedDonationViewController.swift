//
//  DetailedDonationViewController.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 29/08/2018.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import UIKit

class DetailedDonationViewController: KFCModularTableView {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        title = "Donation"
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
