//
//  PendingDonationTableViewCell.swift
//  KifuSF
//
//  Created by Erick Sanchez on 8/25/18.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import UIKit

protocol PendingDonationTableViewCellDelegate: class {
    func pendingDonation(_ pendingDonationCell: PendingDonationTableViewCell, didSelectToCancelRequset: UIButton)
}

class PendingDonationTableViewCell: ItemPostCell {
    
    weak var delegate: PendingDonationTableViewCellDelegate?
    
    func configure(_ donation: Donation) {
        itemName.text = donation.title
        
        itemImage.kf.setImage(with: URL(string: donation.imageUrl)!)
        postInfo.text = "@\(donation.donator.username)"
        
        let distanceTitle = UserService.calculateDistance(long: donation.longitude, lat: donation.laditude)
        distance.text = distanceTitle
    }

    @IBOutlet weak var buttonCancelRequest: UIButton!
    @IBAction func pressCancelRequest(_ sender: Any) {
        delegate?.pendingDonation(self, didSelectToCancelRequset: buttonCancelRequest)
    }
}
