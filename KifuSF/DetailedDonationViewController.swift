//
//  DetailedDonationViewController.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 29/08/2018.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import UIKit

class DetailedDonationViewController: UIViewController {
    
    @IBOutlet weak var requestDeliveryButton: UIButton!
    
    @IBAction func requestDeliveryButtonPressed(_ sender: Any) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpDonationDescription()
        

        requestDeliveryButton.setTitle("Request Delivery", for: .normal)        
        requestDeliveryButton.setUp(with: .button, andColor: .kfPrimary)
        
        title = "Donation"
        view.backgroundColor = UIColor.kfWhite
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: KFImage.flagIcon,
                                                                                  style: .plain,
                                                                                  target: self,
                                                                                  action: #selector(flagButtonPressed))
    }
    
    
    @objc func flagButtonPressed() {
        //TODO: flagging
    }
    
    func setUpDonationDescription() {
        guard let donationDescription = Bundle.main.loadNibNamed(KFDonationDescriptionView.nibName, owner: self, options: nil)?.first as? KFDonationDescriptionView else {
            assertionFailure(KFErrorMessage.nibFileNotFound)
            return
        }
        
        view.addSubview(donationDescription)
        
        donationDescription.translatesAutoresizingMaskIntoConstraints = false
        
        donationDescription.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        donationDescription.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        donationDescription.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
    }

}
