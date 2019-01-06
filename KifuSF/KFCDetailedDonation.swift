//
//  DetailedDonationViewController.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 29/08/2018.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import UIKit

class KFCDetailedDonation: KFCModularTableView {
    
    // MARK: - VARS
    
    var donation: Donation!
    
    enum UserRequestingStatus {
        case userHasNotRequested
        case userHasRequested
        case userAlreadyHasCurrentDelivery
    }
    
    /** default is `.userHasNotRequested` */
    var userRequestingStatus = UserRequestingStatus.userHasNotRequested {
        didSet {
            switch userRequestingStatus {
            case .userHasNotRequested, .userAlreadyHasCurrentDelivery:
                self.actionButton.setMainBackgroundColor(.kfPrimary)
                self.actionButton.setTitle("Request Item", for: .normal)
            case .userHasRequested:
                self.actionButton.setMainBackgroundColor(.kfDestructive)
                self.actionButton.setTitle("Cancel Reqeust", for: .normal)
            }
        }
    }
    
    /** this can say Reqeust Item or Cancel Request */
    private let actionButton = UIAnimatedButton(backgroundColor: .kfPrimary, andTitle: "Request Item")
    
    // MARK: - RETURN VALUES
    
    // MARK: - METHODS
    
    // MARK: - IBACTIONS
    
    @objc func pressActionButton(_ sender: Any) {
        actionButton.isEnabled = false
        
        switch userRequestingStatus {
        case .userHasNotRequested:
            RequestService.createRequest(for: self.donation) { (isSuccessful) in
                self.actionButton.isEnabled = true
                
                if isSuccessful {
                    self.navigationController!.popViewController(animated: true)
                } else {
                    let errorAlert = UIAlertController(errorMessage: nil)
                    self.present(errorAlert, animated: true)
                }
            }
        case .userHasRequested:
            RequestService.cancelRequest(for: self.donation) { (isSuccessful) in
                self.actionButton.isEnabled = true
                
                if isSuccessful {
                    self.navigationController!.popViewController(animated: true)
                } else {
                    let errorAlert = UIAlertController(errorMessage: nil)
                    self.present(errorAlert, animated: true)
                }
            }
        case .userAlreadyHasCurrentDelivery:
            UIAlertController(errorMessage: "You cannot request another item while having a delivery in progress. Please complete your current delivery before requesting another.")
                .present(in: self)
        }
    }
    
    // MARK: - LIFE CYCLE

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Donation"
        view.backgroundColor = UIColor.kfWhite
        modularTableView.separatorStyle = .none

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

        navigationItem.rightBarButtonItem = UIBarButtonItem(image: .kfFlagIcon,
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(flagButtonPressed))
    }

    @objc func flagButtonPressed() {
        //TODO: alex-flagging
    }

    override func retrieveOpenDonationDescriptionItem() -> KFPModularTableViewItem? {
        let imageUrl = URL(string: donation.imageUrl) ?? URL.brokenUrlImage
        let donator = donation.donator
        let distance = UserService.calculateDistance(donation: self.donation)
        
        return KFMOpenDonationDescriptionItem(
            imageURL: imageUrl,
            title: donation.title,
            username: donator.username,
            creationDate: String(describing: donation.creationDate), //TODO: format date
            userReputation: 22, //TODO: alex-reputation
            userDonationsCount: 12, //TODO: alex-reputation
            userDeliveriesCount: 12, //TODO: alex-reputation
            distance: distance,
            description: donation.notes
        )
    }
}
