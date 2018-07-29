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

    var photoHelper = PhotoHelper()

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
        deliveryGreenButtonView.isHidden = false

        switch delivery.status {
        case .Open:
            break
        case .AwaitingPickup:
            deliveryLabelOne.text = delivery.pickUpAddress
            deliveryLabelTwo.text = delivery.donator.contactNumber
            deliveryTextView.text = ""

            deliveryCancelButtonView.isHidden = true
            deliveryGreenButton.setTitle("Directions", for: .normal)

        case .AwaitingDelivery:
            deliveryLabelOne.text = "150 Golden Gate Ave, San Francisco, CA 94102"
            deliveryLabelTwo.text = "415.592.2780"
            deliveryTextView.text = ""

            deliveryCancelButtonView.isHidden = false
            deliveryCancelButton.setTitle("Directions", for: .normal)
            deliveryGreenButton.setTitle("Validate", for: .normal)

        case .AwaitingApproval:
            deliveryLabelOne.text = ""
            deliveryLabelTwo.text = ""
            deliveryTextView.text = ""

            //change button to awaiting approval
            deliveryCancelButtonView.isHidden = true
            deliveryGreenButton.setTitle("Awaiting approval", for: .normal)
        }
    }

    private func updateOpenDonationContainer() {
        guard let donation = openDonation else {
            return assertionFailure("no open delivery to reload")
        }

        donationItemName.text = donation.title
        donationImage.kf.setImage(with: URL(string: donation.imageUrl)!)

        deliveryGreenButtonView.isHidden = false
        deliveryCancelButtonView.isHidden = false

        switch donation.status {
        case .Open:
            donationLabelOne.text = ""
            donationLabelTwo.text = ""
            donationTextView.text = ""

            let nVolunteers = 2
            donationCancelButton.setTitle("Cancel", for: .normal)
            donationGreenButton.setTitle("\(nVolunteers) Volunteers", for: .normal)
        case .AwaitingPickup:
            guard let volunteer = donation.volunteer else {
                fatalError("no volunteer found")
            }

            donationLabelOne.text = volunteer.username
            donationLabelTwo.text = volunteer.contactNumber

            //update button to "confirm pickup"
            //remove cancel button
            donationCancelButtonView.isHidden = true
            donationGreenButton.setTitle("Confirm Pickup", for: .normal)
        case .AwaitingDelivery:
            guard let volunteer = donation.volunteer else {
                fatalError("no volunteer found")
            }

            donationLabelOne.text = volunteer.username
            donationLabelTwo.text = volunteer.contactNumber

            //update buttons to: "in delivery"
            //remove cancel button
            donationCancelButtonView.isHidden = true
            donationGreenButton.setTitle("in delivery", for: .normal)

        case .AwaitingApproval:
            guard let volunteer = donation.volunteer else {
                fatalError("no volunteer found")
            }

            donationLabelOne.text = volunteer.username
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
        case .Open:
            break
        case .AwaitingPickup:
            break
        case .AwaitingDelivery:
            //TODO: show directions
            break
        case .AwaitingApproval:
            break
        }
    }

    @IBAction func deliveryGreenButtonTapped(_ sender: Any) {
        guard let delivery = self.openDelivery else {
            fatalError("no delivery for button action")
        }

        switch delivery.status {
        case .Open:
            break
        case .AwaitingPickup:
            //TODO: show directions of donator location
            break
        case .AwaitingDelivery:
            photoHelper.presentActionSheet(from: self)
        case .AwaitingApproval:
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
        case .Open:
            //TODO: cancel button
            break
        case .AwaitingPickup:
            break
        case .AwaitingDelivery:
            break
        case .AwaitingApproval:
            break
        }
    }

    @IBAction func donationGreenButtonTapped(_ sender: Any) {
        guard let donation = self.openDonation else {
            fatalError("no delivery for button action")
        }

        switch donation.status {
        case .Open:
            self.performSegue(withIdentifier: "show volunteers", sender: nil)
        case .AwaitingPickup:
            let alertConfirmPickup = UIAlertController(title: nil, message: "are you sure you want to confirm the pickup?", preferredStyle: .actionSheet)
            let actionConfirm = UIAlertAction(title: "Confirm Pickup", style: .destructive) { (_) in
                DonationService.confirmPickup(for: donation, completion: { (success) in
                    if success {
                        self.😱()
                    }
                    //TODO: print error message
                })
            }
            alertConfirmPickup.addAction(actionConfirm)
            alertConfirmPickup.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            present(alertConfirmPickup, animated: true)
        case .AwaitingDelivery:
            break
        case .AwaitingApproval:
            guard
                let photoVc = storyboard!.instantiateViewController(withIdentifier: "approveDelivery") as? ApproveDeliveryViewController,
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

        //validate photo picked
        photoHelper.completionHandler = { image in
            guard let donation = self.openDelivery else {
                fatalError("some programmer didn't had enough sleep")
            }

            DonationService.confirmDelivery(for: donation, image: image, completion: { (success) in
                if success {
                    self.😱()
                }
                //TODO: handle error
            })
        }

        updateUI()
    }

    private func 😱() {
        DonationService.showOpenDontationAndDelivery { (donation, delivery) in
            self.openDelivery = delivery
            self.openDonation = donation

            self.updateUI()
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        😱()
    }
}
