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

    var openDonation: Donation?

    var openDelivery: Donation?

    var sendValidationPhotoHelper = PhotoHelper()

    // MARK: - RETURN VALUES

    // MARK: - VOID METHODS

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            switch identifier {
            case "show volunteers":
                guard let destination = segue.destination as? VolunteerListViewController else {
                    fatalError("somebody didn't had enough sleep")
                }

                destination.donation = openDonation
            default:
                break
            }
        }
    }

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

        deliveryCancelButtonView.isHidden = false
        deliveryCancelButtonView.backgroundColor = UIColor.red
        deliveryGreenButtonView.isHidden = false
        deliveryGreenButtonView.backgroundColor = UIColor.green

        switch delivery.status {
        case .open:
            break
        case .awaitingPickup:
            deliveryLabelOne.text = delivery.pickUpAddress
            deliveryLabelTwo.text = delivery.donator.contactNumber
            deliveryTextView.text = ""

            deliveryCancelButtonView.isHidden = true
            deliveryGreenButtonView.backgroundColor = UIColor.blue
            deliveryGreenButton.setTitle("Directions", for: .normal)

        case .awaitingDelivery:
            deliveryLabelOne.text = "150 Golden Gate Ave, San Francisco, CA 94102"
            deliveryLabelTwo.text = "415.592.2780"
            deliveryTextView.text = ""

            deliveryCancelButtonView.backgroundColor = UIColor.blue
            deliveryCancelButton.setTitle("Directions", for: .normal)
            deliveryGreenButton.setTitle("Validate", for: .normal)

        case .awaitingApproval:
            deliveryLabelOne.text = ""
            deliveryLabelTwo.text = ""
            deliveryTextView.text = ""

            //change button to awaiting approval
            deliveryCancelButtonView.isHidden = true
            deliveryGreenButton.setTitle("Awaiting approval", for: .normal)
        }
    }

    private func updateOpenDonationContainer() { // swiftlint:disable:this function_body_length
        guard let donation = openDonation else {
            return assertionFailure("no open donation to reload")
        }

        donationItemName.text = donation.title
        donationImage.kf.setImage(with: URL(string: donation.imageUrl)!)
        donationLabelOne.isHidden = false
        donationLabelTwo.isHidden = false
        donationTextView.text = ""

        donationGreenButtonView.isHidden = false
        donationCancelButtonView.isHidden = false

        switch donation.status {
        case .open:
            donationLabelOne.isHidden = true
            donationLabelTwo.isHidden = true
            donationTextView.text = donation.notes
            
            donationCancelButton.setTitle("Cancel", for: .normal)
            self.donationGreenButton.setTitle("Show Volunteers", for: .normal)
            
            DonationService.getNumberOfVolunteers(for: donation) { (nVolunteers) in
                
                //TODO: remove observer
                switch donation.status {
                case .open:
                    self.donationGreenButton.setTitle("\(nVolunteers) Volunteers", for: .normal)
                default: break
                }
            }
        case .awaitingPickup:
            guard let volunteer = donation.volunteer else {
                fatalError("no volunteer found")
            }
            
            donationLabelOne.text = "@\(volunteer.username)"
            donationLabelTwo.text = volunteer.contactNumber
            
            //update button to "confirm pickup"
            //remove cancel button
            donationCancelButtonView.isHidden = true
            donationGreenButton.setTitle("Confirm Pickup", for: .normal)
        case .awaitingDelivery:
            guard let volunteer = donation.volunteer else {
                fatalError("no volunteer found")
            }

            donationLabelOne.text = "@\(volunteer.username)"
            donationLabelTwo.text = volunteer.contactNumber

            //update buttons to: "in delivery"
            //remove cancel button
            donationCancelButtonView.isHidden = true
            donationGreenButton.setTitle("in delivery", for: .normal)

        case .awaitingApproval:
            guard let volunteer = donation.volunteer else {
                fatalError("no volunteer found")
            }

            donationLabelOne.text = "@\(volunteer.username)"
            donationLabelTwo.text = volunteer.contactNumber

            //update button to verify delivery
            //remove cancel button
            donationCancelButtonView.isHidden = true
            donationGreenButton.setTitle("verify delivery", for: .normal)
        }
    }

    // MARK: - IBACTIONS

    @IBOutlet weak var deliveryItemName: UILabel!
    @IBOutlet weak var deliveryLabelOne: UILabel!
    @IBOutlet weak var deliveryLabelTwo: UILabel!
    @IBOutlet weak var deliveryTextView: UITextView!
    @IBOutlet weak var deliveryCancelButtonView: GradientView!
    @IBOutlet weak var deliveryGreenButtonView: GradientView!
    @IBOutlet weak var deliveryImage: UIImageView!
    @IBOutlet weak var deliveryGreenButton: UIButton!
    @IBOutlet weak var deliveryCancelButton: UIButton!

    @IBOutlet weak var donationItemName: UILabel!
    @IBOutlet weak var donationLabelOne: UILabel!
    @IBOutlet weak var donationLabelTwo: UILabel!
    @IBOutlet weak var donationTextView: UITextView!
    @IBOutlet weak var donationCancelButtonView: GradientView!
    @IBOutlet weak var donationGreenButtonView: GradientView!
    @IBOutlet weak var donationImage: UIImageView!
    @IBOutlet weak var donationGreenButton: UIButton!
    @IBOutlet weak var donationCancelButton: UIButton!

    @IBOutlet weak var deliveryContainer: GradientView!
    @IBOutlet weak var emptyDeliveryContainer: GradientView!

    //Below: Delivery
    @IBAction func deliveryCancelButtonTapped(_ sender: Any) {
        guard let delivery = self.openDelivery else {
            fatalError("no delivery for button action")
        }

        switch delivery.status {
        case .open:
            break
        case .awaitingPickup:
            break
        case .awaitingDelivery:
            //TODO: show directions to charity. use MapHelper
            break
        case .awaitingApproval:
            break
        }
    }

    @IBAction func deliveryGreenButtonTapped(_ sender: Any) {
        guard let delivery = self.openDelivery else {
            fatalError("no delivery for button action")
        }

        switch delivery.status {
        case .open:
            break
        case .awaitingPickup:
            let directionsMap = MapHelper(long: delivery.longitude, lat: delivery.laditude)
            directionsMap.open()
        case .awaitingDelivery:
            sendValidationPhotoHelper.presentActionSheet(from: self)
        case .awaitingApproval:
            break
        }
    }

    @IBOutlet weak var donationContainer: GradientView!
    @IBOutlet weak var emptyDonationContainer: GradientView!

    //Below: Donation
    @IBAction func donationCancelButtonTapped(_ sender: Any) {
        guard let donation = self.openDonation else {
            fatalError("no delivery for button action")
        }

        switch donation.status {
        case .open:
            let cancelDonationAlert = UIAlertController(
                title: "Cancel Donation",
                message: "Are you sure you want to cancel your open donation?",
                preferredStyle: .alert
            )
            
            let deleteDonationAction = UIAlertAction(
                title: "Delete Donation",
                style: .destructive) { (_) in
                    DonationService.cancel(donation: donation, completion: { (successful) in
                        if successful == false {
                            let errorAlert = UIAlertController(errorMessage: nil)
                            self.present(errorAlert, animated: true)
                        } else {
                            //observe will update the UI
                            //self.updateUI()
                        }
                    })
            }
            cancelDonationAlert.addAction(deleteDonationAction)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
            cancelDonationAlert.addAction(cancelAction)
            
            present(cancelDonationAlert, animated: true)
        case .awaitingPickup:
            break
        case .awaitingDelivery:
            break
        case .awaitingApproval:
            break
        }
    }

    @IBAction func donationGreenButtonTapped(_ sender: Any) {
        guard let donation = self.openDonation else {
            fatalError("no delivery for button action")
        }

        switch donation.status {
        case .open:
            self.performSegue(withIdentifier: "show volunteers", sender: nil)
        case .awaitingPickup:
            let alertConfirmPickup = UIAlertController(
                title: nil,
                message: "are you sure you want to confirm the pickup?",
                preferredStyle: .actionSheet
            )
            let actionConfirm = UIAlertAction(title: "Confirm Pickup", style: .destructive) { (_) in
                DonationService.confirmPickup(for: donation, completion: { (success) in
                    if success {
                        self.observeChanges()
                    }
                    //TODO: print error message
                })
            }
            alertConfirmPickup.addAction(actionConfirm)
            alertConfirmPickup.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            present(alertConfirmPickup, animated: true)
        case .awaitingDelivery:
            break
        case .awaitingApproval:
            guard
                let photoVc = storyboard!.instantiateViewController(withIdentifier: "approveDelivery") as? ApproveDeliveryViewController, // swiftlint:disable:this line_length
                let donation = self.openDonation else {
                fatalError("bad progammer 🤓")
            }

            photoVc.donation = donation
            present(photoVc, animated: true)
        }
    }

    @IBAction func emptyDeliveryButtonTapped(_ sender: Any) {
        
        //move to items screen
        tabBarController!.selectedIndex = 0
    }

    // MARK: - Navigation

    // MARK: - LIFE CYCLE

    override func viewDidLoad() {
        super.viewDidLoad()
        
        observeChanges()

        //validate photo picked
        sendValidationPhotoHelper.completionHandler = { image in
            guard let donation = self.openDelivery else {
                fatalError("some programmer didn't had enough sleep")
            }

            DonationService.confirmDelivery(for: donation, image: image, completion: { (success) in
                if success {
                    self.observeChanges()
                }
                //TODO: handle error
            })
        }

        updateUI()
    }

    private func observeChanges() {
        DonationService.observeOpenDonationAndDelivery { (donation, delivery) in
            self.openDelivery = delivery
            self.openDonation = donation

            self.updateUI()
        }
    }
}
