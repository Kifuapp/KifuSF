//
//  DonationPostViewController.swift
//  KifuSF
//
//  Created by Shutaro Aoyama on 2018/07/28.
//  Copyright © 2018年 Alexandru Turcanu. All rights reserved.
//

import UIKit
import LocationPicker
import CoreLocation

class DonationPostViewController: UIViewController {

    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var itemNameField: UITextField!
    @IBOutlet weak var itemDescriptionTextView: UITextView!

    let photoHelper = PhotoHelper()
    var currentLocation: Location?

    override func viewDidLoad() {
        super.viewDidLoad()

        photoHelper.completionHandler = { image in
            self.itemImage.image = image
        }

        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(UIInputViewController.dismissKeyboard)
        )
        view.addGestureRecognizer(tap)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func cancelButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func imageSelectionButtonTapped(_ sender: Any) {
        photoHelper.presentActionSheet(from: self)
    }

    @IBAction func setLocationButtonTapped(_ sender: Any) {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "locationVC":
            if let destinationVC = segue.destination as? LocationPickerViewController {
                
                destinationVC.showCurrentLocationInitially = true
                destinationVC.searchBarPlaceholder = "Choose Pickup location"
                destinationVC.mapType = .standard
                
                destinationVC.showCurrentLocationButton = true
                
                destinationVC.completion = { location in
                   self.currentLocation = location
                }
            }
        default:
            print("unknown segue identifier")
        }
    }
    
    @IBAction func donateButtonTapped(_ sender: Any) {
        //validate if the fields are empty
        if itemNameField.text!.isEmpty || itemDescriptionTextView.text.isEmpty {
            errorLabel.text = "Fill in everything"
            return
        }

        //validate the image is not the default image
        if itemImage.image == UIImage(named: "PlusSquare") {
            errorLabel.text = "Set the photo"
            return
        }

        let itemTitle = itemNameField.text!
        let detailText = itemDescriptionTextView.text!
        let image = itemImage.image!

        //TODO: Shu-Address picker, store the address string and long and lat
        
        guard let currentLocation = currentLocation else {
            assertionFailure("location failed")
            return
        }

        //Post the Donation
        DonationService.createDonation(
            title: itemTitle,
            notes: detailText,
            image: image,
            pickUpAddress: currentLocation.address,
            longitude: currentLocation.coordinate.longitude,
            latitude: currentLocation.coordinate.latitude) { [weak self] (_) in
                //Then dismiss
                self?.dismiss(animated: true, completion: nil)
        }
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

}
