//
//  KFVRequestedDonationCell.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 06/09/2018.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import UIKit

class KFVRequestedDonationCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }


}

extension KFVRequestedDonationCell: KFPRegistableCell {
    static var nibName: String = "KFVRequestedDonationCell"
    static var reuseIdentifier: String = "requestedDonationCell"
}
