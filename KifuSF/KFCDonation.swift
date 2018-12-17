//
//  KFCDonation.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 19/09/2018.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import CoreLocation

class KFCDonation: KFCModularTableView {
    
    var donation: Donation? {
        didSet {
            updateUI()
        }
    }

    let actionButton = UIAnimatedButton(backgroundColor: .kfInformative, andTitle: "Directions")
    
    private func updateUI() {
        reloadData()
        
        //update the actionButton
        actionButton.isHidden = false
        
        if let donation = self.donation {
            switch donation.status {
            case .open:
                actionButton.setTitle("View Requests", for: .normal)
            case .awaitingPickup:
                actionButton.setTitle("Confirm Drop Off", for: .normal)
            case .awaitingDelivery:
                actionButton.isHidden = true
            case .awaitingApproval:
                actionButton.setTitle("View Confirmation", for: .normal)
            }
        } else {
            actionButton.setTitle("Post a New Donation", for: .normal)
        }
    }

    override func loadView() {
        super.loadView()

        view.addSubview(actionButton)
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        actionButton.autoPinEdge(toSuperviewEdge: .bottom, withInset: 16)
        actionButton.autoPinEdge(toSuperviewEdge: .leading, withInset: 16)
        actionButton.autoPinEdge(toSuperviewEdge: .trailing, withInset: 16)
        actionButton.addTarget(
            self,
            action: #selector(pressActionButton(_:)),
            for: .touchUpInside
        )
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.kfSuperWhite
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        modularTableView.contentInset.bottom = actionButton.frame.height + 16
        modularTableView.scrollIndicatorInsets.bottom = actionButton.frame.height + 16
    }

    override func retrieveProgressItem() -> KFPModularTableViewItem? {
        guard
            let donationStep = self.donation?.status.step,
            donationStep != .stepNone else {
            return nil
        }
        
        return KFMProgress(currentStep: donationStep, ofType: .donation)
    }

    override func retrieveInProgressDonationDescription() -> KFPModularTableViewItem? {
        guard let donationDescription = self.donation?.inProgressDescriptionForDonator else {
            return nil
        }
        
        return donationDescription
    }

    override func retrieveEntityInfoItem() -> KFPModularTableViewItem? {
        guard let delivery = self.donation else {
            return nil
        }
        
        //TODO: erick-collect info of what charity was selected for the donation
        return KFMEntityInfo(
            name: "Make School",
            phoneNumber: "+1 (415) 814-0980",
            address: "1547 Mission St San Francisco, CA  94103",
            entityType: .charity
        )
    }

    override func retrieveCollaboratorInfoItem() -> KFPModularTableViewItem? {
        guard let volunteer = donation?.volunteer else {
            return nil
        }
        
        return volunteer.collaboratorInfo
    }

    override func retrieveDestinationMapItem() -> KFPModularTableViewItem? {
        guard let donation = donation else {
            return nil
        }
        
        let location = CLLocationCoordinate2D(
            latitude: donation.latitude,
            longitude: donation.longitude
        )
        
        return KFMDestinationMap(coordinate: location)
    }
    
    @objc func pressActionButton(_ sender: Any) {
        if let donation = self.donation {
            switch donation.status {
            case .open:
                
                let loading = KFCLoading(style: .whiteLarge)
               loading.present()
                
                //fetch user objects for the given donation
                RequestService.retrieveVolunteers(for: donation) { (volunteers) in
                    loading.dismiss {
                        let volunteersListVC = KFCVolunteerList()
                        volunteersListVC.volunteers = volunteers
                        volunteersListVC.donation = donation
                        self.navigationController?.pushViewController(volunteersListVC, animated: true)
                    }
                }
            case .awaitingPickup:
                
                //Confirm drop off
                self.confirmDropOff(for: donation)
            case .awaitingDelivery:
                assertionFailure("action button should not be tappable here")
            case .awaitingApproval:
                self.viewConfirmationImage(for: donation)
            }
        } else {
            
            //present new donation editor
            let createDonationStoryboard = UIStoryboard(name: "CreateDonation", bundle: nil)
            if let createDonationVC = createDonationStoryboard.instantiateInitialViewController() {
                present(createDonationVC, animated: true)
            } else {
                assertionFailure("error")
            }
        }
    }
    
    private func confirmDropOff(for donation: Donation) {
        let confirmDropOffAlert = UIAlertController(
            title: "Confirm Drop Off",
            message: "Are you sure you want to confirm the drop off of this item?",
            preferredStyle: .actionSheet
        )
        let confirmAction = UIAlertAction(title: "Confirm Drop Off", style: .destructive) { _ in
            DonationService.confirmPickup(for: donation, completion: { (isSuccessful) in
                if isSuccessful {
                    
                    //update the status and the UI
                    self.donation?.status = .awaitingDelivery
                    self.updateUI()
                } else {
                    let alertError = UIAlertController(errorMessage: nil)
                    self.present(alertError, animated: true)
                }
            })
        }
        confirmDropOffAlert.addAction(confirmAction)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        confirmDropOffAlert.addAction(cancelAction)
        
        self.present(confirmDropOffAlert, animated: true)
    }
    
    private func viewConfirmationImage(for donation: Donation) {
        
        //TODO: alex-present the donation verification image vc
        
    }
}

extension KFCDonation: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Donation")
    }
}
