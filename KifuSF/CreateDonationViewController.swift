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
        
        setUpUI()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        
    }
    
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            self.view.frame.origin.y -= keyboardSize.height
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            self.view.frame.origin.y += keyboardSize.height
        }
    }
    
    @objc func dismissVC() {
        dismiss(animated: true, completion: nil)
    }
}


extension CreateDonationViewController {
    func setUpUI() {
        title = "Create Donation"
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dismissVC))
        
        view.backgroundColor = .kfGray
        
        donationImageContainerView.backgroundColor = UIColor.kfWhite
        donationImageContainerView.layer.setUpShadow()
        donationImageContainerView.layer.cornerRadius = CALayer.kfCornerRadius
        
        donationImageView.contentMode = .scaleAspectFill
        donationImageView.layer.cornerRadius = CALayer.kfCornerRadius
        donationImageView.contentMode = .scaleAspectFill
        
        let tintableImage = UIImage.kfPlusIcon.withRenderingMode(.alwaysTemplate)
        donationImageView.image = tintableImage
        donationImageView.tintColor = .kfPrimary
        
        donationInfoButton.setTitle("  Donating?", with: .subheader1)
        donationInfoLabel.setUp(with: .body1)
        donationTitleLabel.setUp(with: .subheader1)
        
        donationTextFieldContainerView.backgroundColor = .kfWhite
        donationTextFieldContainerView.layer.setUpShadow()
        donationTextFieldContainerView.layer.cornerRadius = CALayer.kfCornerRadius
        
        donationTextField.backgroundColor = .clear
        donationTextField.borderStyle = .none
        donationTextField.placeholder = "Keep it simple, only a few words"
        donationTextField.setUp(with: .subheader2, andColor: .clear)
        
        descriptionTitleLabel.setUp(with: .subheader1)
        descriptionTextView.setUp(with: .subheader2, andColor: .clear)
        
        descriptionTextViewContainerView.backgroundColor = .kfWhite
        descriptionTextViewContainerView.layer.setUpShadow()
        descriptionTextViewContainerView.layer.cornerRadius = CALayer.kfCornerRadius
        
        pickupAddressButton.setUp(with: .button, andColor: .kfInformative)
        pickupAddressButton.setTitle("Choose Pick-up address", for: .normal)
        
        infoPickupAddressButton.setTitle("  How it works?", with: .button)
        infoPickupAddressButton.tintColor = UIColor.kfInformative
    }
}
