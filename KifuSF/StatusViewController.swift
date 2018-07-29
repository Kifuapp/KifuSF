//
//  StatusViewController.swift
//  KifuSF
//
//  Created by Shutaro Aoyama on 2018/07/28.
//  Copyright © 2018年 Alexandru Turcanu. All rights reserved.
//

import UIKit
import Kingfisher

class StatusViewController: UIViewController {
    
    var openDonation: OpenDonation?
    
    var openDelivery: OpenDonation?
    
    // MARK: - RETURN VALUES
    
    // MARK: - VOID METHODS
    
    private func updateUI() {
        if openDonation != nil {
            emptyDonationContainer.isHidden = true
            donationContainer.isHidden = false
            
            updateOpenDonationContainer()
        } else {
            emptyDonationContainer.isHidden = false
            donationContainer.isHidden = true
        }
        
        if openDelivery != nil {
            emptyDeliveryContainer.isHidden = true
            deliveryContainer.isHidden = false
            
            updateOpenDeliveryContainer()
        } else {
            emptyDeliveryContainer.isHidden = false
            deliveryContainer.isHidden = true
        }
    }
    
    private func updateOpenDeliveryContainer() {
        guard let delivery = openDelivery else {
            return assertionFailure("no open delivery to reload")
        }
        
        deliveryItemName.text = delivery.title
        deliveryImage.kf.setImage(with: URL(string: delivery.imageUrl)!)
        deliveryTextView.text = delivery.notes
        
        switch delivery.status {
        case .Open:
            break
        case .AwaitingPickup:
            deliveryLabelOne.text = delivery.pickUpAddress
            deliveryLabelTwo.text = delivery.donator.contactNumber
        default:
            break
        }
    }
    
    private func updateOpenDonationContainer() {
        
    }
    
    // MARK: - IBACTIONS
    
    @IBOutlet weak var deliveryItemName: UILabel!
    @IBOutlet weak var deliveryLabelOne: UILabel!
    @IBOutlet weak var deliveryLabelTwo: UILabel!
    @IBOutlet weak var deliveryTextView: UITextView!
    @IBOutlet weak var deliveryCancelButtonView: GradientView!
    @IBOutlet weak var deliveryGreenButtonView: GradientView!
    @IBOutlet weak var deliveryImage: UIImageView!
    
    @IBOutlet weak var donationItemName: UILabel!
    @IBOutlet weak var donationLabelOne: UILabel!
    @IBOutlet weak var donationLabelTwo: UILabel!
    @IBOutlet weak var donationTextView: UITextView!
    @IBOutlet weak var donationCancelButtonView: GradientView!
    @IBOutlet weak var donationGreenButtonView: GradientView!
    @IBOutlet weak var donationImage: UIImageView!
    
    @IBOutlet weak var deliveryContainer: GradientView!
    @IBOutlet weak var emptyDeliveryContainer: GradientView!
    
    //Below: Delivery
    @IBAction func deliveryCancelButtonTapped(_ sender: Any) {
    }
    
    @IBAction func deliveryGreenButtonTapped(_ sender: Any) {
    }
    
    @IBOutlet weak var donationContainer: GradientView!
    @IBOutlet weak var emptyDonationContainer: GradientView!
    
    //Below: Donation
    @IBAction func donationCancelButtonTapped(_ sender: Any) {
    }
    
    @IBAction func donationGreenButtonTapped(_ sender: Any) {
    }
    
    // MARK: - LIFE CYCLE
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        DonationService.showOpenDontationAndDelivery { (donation, delivery) in
            self.openDelivery = delivery
            self.openDonation = donation
            
            self.updateUI()
        }
    }
}
