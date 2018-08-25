//
//  ApproveDeliveryViewController.swift
//  KifuSF
//
//  Created by Shutaro Aoyama on 2018/07/29.
//  Copyright © 2018年 Alexandru Turcanu. All rights reserved.
//

import UIKit
import Kingfisher

class ApproveDeliveryViewController: UIViewController {
    
    var donation: Donation!
    
    // MARK: - RETURN VALUES
    
    // MARK: - VOID METHODS
    
    // MARK: - IBACTIONS
    
    @IBOutlet weak var itemImage: UIImageView!

    @IBAction func approveButtonTapped(_ sender: Any) {
        DonationService.verifyDelivery(for: donation) { (success) in
            if success {
                let rewardAction = UIAlertController(
                    title: "Congrats",
                    message: "You have just completed your first donation, reward: 50 contribution points",
                    preferredStyle: .alert
                )
                rewardAction.addAction(UIAlertAction(title: "Horay!", style: .default, handler: { (_) in
                    self.presentingViewController?.dismiss(animated: true)
                }))
                
                self.present(rewardAction, animated: true)
            } else {
                //TODO: display error
            }
        }
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - LIFE CYCLE
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let imageUrl = donation.verificationUrl else {
            fatalError("missing verification url")
        }
        
        itemImage.kf.setImage(with: URL(string: imageUrl)!)
    }

}
