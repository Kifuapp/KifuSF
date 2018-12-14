//
//  CreateDonationViewController.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 30/08/2018.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import UIKit
import LocationPicker

class KFCCreateDonation: UIViewController {
    
    // MARK: - VARS
    
    private var currentLocation: Location?
    
    private lazy var imagePicker = PhotoHelper()
    
    private var pickupLocation: Location?
    
    // MARK: - RETURN VALUES
    
    // MARK: - METHODS
    
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
    
    private func validateInput() -> Bool {
        
        //validate if the fields are empty
        if donationTextField.text?.isEmpty ?? false || descriptionTextView.text.isEmpty {
            return false
        }
        
        //validate the image is not the default image
        if donationImageView.image == UIImage(named: "PlusSquare") {
            return false
        }
        
        return true
    }
    
    // MARK: - IBACTIONS
    
    @IBOutlet weak var donationImageContainerView: UIView!
    @IBOutlet weak var donationImageView: UIImageView!
    @objc func tapDonationImage(_ sender: Any) {
        imagePicker.completionHandler = { [unowned self] image in
            self.donationImageView.image = image
        }
        imagePicker.presentActionSheet(from: self)
    }
    
    @IBOutlet weak var donationInfoButton: UIButton!
    @IBOutlet weak var donationInfoLabel: UILabel!
    
    @IBOutlet weak var donationTitleLabel: UILabel!
    @IBOutlet weak var donationTextFieldContainerView: UIView!
    @IBOutlet weak var donationTextField: UITextField!
    
    @IBOutlet weak var descriptionTitleLabel: UILabel!
    @IBOutlet weak var descriptionTextViewContainerView: UIView!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    @IBOutlet weak var pickupAddressButton: UIButton!
    @objc func pressPickupAddress(_ sender: Any) {
        guard self.validateInput() else {
            //TODO: alex-present an error with a label or alert?
            return
        }
        
        let locationPicker = LocationPickerViewController()
        
        locationPicker.showCurrentLocationInitially = true
        locationPicker.searchBarPlaceholder = "Choose Pickup location"
        locationPicker.mapType = .standard
        
        locationPicker.showCurrentLocationButton = true
        
        locationPicker.completion = { location in
            guard let location = location else {
                return print("no location selected")
            }
            
            self.pickupLocation = location
        }
        
        self.navigationController?.pushViewController(locationPicker, animated: true)
    }
    
    @IBOutlet weak var infoPickupAddressButton: UIButton!
    
    // MARK: - LIFE CYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.keyboardWillShow),
            name: NSNotification.Name.UIKeyboardWillShow,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.keyboardWillHide),
            name: NSNotification.Name.UIKeyboardWillHide,
            object: nil
        )
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let location = self.pickupLocation {
            
            let loadingVc = KFCLoading(style: .whiteLarge)
            loadingVc.present()
            
            guard
                let itemTitle = self.donationTextField.text,
                let detailText = self.descriptionTextView.text,
                let image = self.donationImageView.image else {
                    return assertionFailure("missing input before uploading")
            }
            
            //Post the Donation
            DonationService.createDonation(
                title: itemTitle,
                notes: detailText,
                image: image,
                pickUpAddress: location.address,
                longitude: location.coordinate.longitude,
                latitude: location.coordinate.latitude) { donation in
                    loadingVc.dismiss {
                        if donation == nil {
                            let errorAlert = UIAlertController(errorMessage: nil)
                            self.present(errorAlert, animated: true)
                        } else {
                            self.presentingViewController?.dismiss(animated: true, completion: nil)
                        }
                    }
            }
        }
    }
}

extension KFCCreateDonation {
    func setUpUI() {
        title = "Create Donation"
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .cancel,
            target: self,
            action: #selector(dismissVC)
        )
        
        view.backgroundColor = .kfGray
        
        donationImageContainerView.backgroundColor = UIColor.kfSuperWhite
        donationImageContainerView.layer.setUpShadow()
        donationImageContainerView.layer.cornerRadius = CALayer.kfCornerRadius
        
        donationImageView.contentMode = .scaleAspectFill
        donationImageView.layer.cornerRadius = CALayer.kfCornerRadius
        donationImageView.contentMode = .scaleAspectFill
        
        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(tapDonationImage(_:))
        )
        donationImageView.isUserInteractionEnabled = true
        donationImageView.addGestureRecognizer(tapGesture)


        let tintableImage = UIImage.kfPlusImage.withRenderingMode(.alwaysTemplate)
        donationImageView.image = tintableImage
        donationImageView.tintColor = .kfPrimary
        
        donationInfoButton.setTitle("  Donating?", with: .subheader1)
        donationInfoLabel.setUp(with: .body1)
        donationTitleLabel.setUp(with: .subheader1)
        
        donationTextFieldContainerView.backgroundColor = .kfSuperWhite
        donationTextFieldContainerView.layer.setUpShadow()
        donationTextFieldContainerView.layer.cornerRadius = CALayer.kfCornerRadius
        
        donationTextField.backgroundColor = .clear
        donationTextField.borderStyle = .none
        donationTextField.placeholder = "Keep it simple, only a few words"
        donationTextField.setUp(with: .subheader2, andColor: .clear)
        
        descriptionTitleLabel.setUp(with: .subheader1)
        descriptionTextView.setUp(with: .subheader2, andColor: .clear)
        
        descriptionTextViewContainerView.backgroundColor = .kfSuperWhite
        descriptionTextViewContainerView.layer.setUpShadow()
        descriptionTextViewContainerView.layer.cornerRadius = CALayer.kfCornerRadius
        
        pickupAddressButton.setUp(with: .button, andColor: .kfInformative)
        pickupAddressButton.setTitle("Choose Pick-up address", for: .normal)
        pickupAddressButton.addTarget(
            self,
            action: #selector(pressPickupAddress(_:)),
            for: .touchUpInside
        )
        
        infoPickupAddressButton.setTitle("  How it works?", with: .button)
        infoPickupAddressButton.tintColor = UIColor.kfInformative
    }
}
