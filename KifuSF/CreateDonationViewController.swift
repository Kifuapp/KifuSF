//
//  CreateDonationViewController.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 30/08/2018.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import UIKit

class CreateDonationViewController: UIViewController {

    @IBOutlet weak var donationImageContainerView: UIView!
    @IBOutlet weak var donationImageView: UIImageView!
    
    @IBOutlet weak var donationInfoButton: UIButton!
    @IBOutlet weak var donationInfoLabel: UILabel!
    
    @IBOutlet weak var donationTitleLabel: UILabel!
    @IBOutlet weak var donationTextFieldContainerView: UIView!
    @IBOutlet weak var donationTextField: UITextField!
    
    @IBOutlet weak var descriptionTitleLabel: UILabel!
    @IBOutlet weak var descriptionTextViewContainerView: UIView!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    @IBOutlet weak var pickupAddressButton: UIButton!
    @IBOutlet weak var infoPickupAddressButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Create Donation"
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dismissVC))
        
        view.backgroundColor = .kfGray
        
        donationImageContainerView.backgroundColor = UIColor.kfWhite
        donationImageContainerView.layer.setUpShadow()
        donationImageContainerView.layer.cornerRadius = CALayer.kfCornerRadius
        
        donationImageView.contentMode = .scaleAspectFill
        donationImageView.layer.cornerRadius = CALayer.kfCornerRadius
        donationImageView.contentMode = .scaleAspectFill
        
        let tintableImage = KFImage.plusIcon.withRenderingMode(.alwaysTemplate)
        donationImageView.image = tintableImage
        donationImageView.tintColor = .kfPrimary

        donationInfoButton.setTitle("  What to donate?", with: .subheader1)
        donationInfoLabel.setUp(with: .body1)
        donationTitleLabel.setUp(with: .subheader1)
        
        donationTextFieldContainerView.backgroundColor = .kfWhite
        donationTextFieldContainerView.layer.setUpShadow()
        donationTextFieldContainerView.layer.cornerRadius = CALayer.kfCornerRadius
        
        donationTextField.backgroundColor = .clear
        donationTextField.borderStyle = .none
        donationTextField.placeholder = "Keep it simple, only a few words"
        donationTextField.setUp(with: .body1, andColor: .clear)
        
        descriptionTitleLabel.setUp(with: .subheader1)
        descriptionTextView.setUp(with: .body1, andColor: .clear)
        
        descriptionTextViewContainerView.backgroundColor = .kfWhite
        descriptionTextViewContainerView.layer.setUpShadow()
        descriptionTextViewContainerView.layer.cornerRadius = CALayer.kfCornerRadius
        
        pickupAddressButton.setUp(with: .button, andColor: .kfInformative)
        pickupAddressButton.setTitle("Choose Pick-up address", for: .normal)
        
        infoPickupAddressButton.setTitle("  What's this?", with: .button)
        infoPickupAddressButton.tintColor = UIColor.kfInformative
    }
    
    @objc func dismissVC() {
        dismiss(animated: true, completion: nil)
    }
    
    


}
