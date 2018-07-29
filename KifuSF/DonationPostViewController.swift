//
//  DonationPostViewController.swift
//  KifuSF
//
//  Created by Shutaro Aoyama on 2018/07/28.
//  Copyright © 2018年 Alexandru Turcanu. All rights reserved.
//

import UIKit

class DonationPostViewController: UIViewController {

    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var itemNameField: UITextField!
    @IBOutlet weak var itemDescriptionTextView: UITextView!

    let photoHelper = PhotoHelper()

    override func viewDidLoad() {
        super.viewDidLoad()

        photoHelper.completionHandler = { image in
            self.itemImage.image = image
        }

        // Do any additional setup after loading the view.

        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
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

        //Post the Donation
        DonationService.createDonation(
            title: itemTitle,
            notes: detailText,
            image: image,
            pickUpAddress: "NOT IMPLEMENTED",
            longitude: 123,
            latitude: 123) { [weak self] (_) in

                //Then dismiss
                self?.dismiss(animated: true, completion: nil)
        }
    }

    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
