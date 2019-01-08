//
//  DetailedDonationViewController.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 29/08/2018.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import UIKit

class DetailedDonationModularTableViewController: ModularTableViewController {
    // MARK: - Variables
    var donation: Donation!
    
    var hasUserAlreadyRequested: Bool = false {
        didSet {
            if hasUserAlreadyRequested {
                self.actionButton.setMainBackgroundColor(UIColor.Pallete.Red)
                self.actionButton.setTitle("Cancel Reqeust", for: .normal)
            } else {
                self.actionButton.setMainBackgroundColor(UIColor.Pallete.Green)
                self.actionButton.setTitle("Request Item", for: .normal)
            }
        }
    }
    
    /** this can say Reqeust Item or Cancel Request */
    private let actionButton = UIAnimatedButton(backgroundColor: UIColor.Pallete.Green,
                                                andTitle: "Request Item")

    // MARK: - Methods
    @objc func flagButtonPressed() {
        //TODO: alex-flagging
    }

    override func retrieveOpenDonationDescriptionItem() -> ModularTableViewItem? {
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

    @objc func pressActionButton(_ sender: Any) {
        actionButton.isEnabled = false

        if hasUserAlreadyRequested {
            RequestService.cancelRequest(for: self.donation) { (isSuccessful) in
                self.actionButton.isEnabled = true

                if isSuccessful {
                    self.hasUserAlreadyRequested = false
                } else {
                    let errorAlert = UIAlertController(errorMessage: nil)
                    self.present(errorAlert, animated: true)
                }
            }
        } else {
            RequestService.createRequest(for: self.donation) { (isSuccessful) in
                self.actionButton.isEnabled = true

                if isSuccessful {
                    self.hasUserAlreadyRequested = true
                } else {
                    let errorAlert = UIAlertController(errorMessage: nil)
                    self.present(errorAlert, animated: true)
                }
            }
        }
    }

    // MARK: - UITableViewDataSource
    override func numberOfSections(in tableView: UITableView) -> Int {
        if items.isEmpty {
            tableView.backgroundView?.isHidden = false
        } else {
            tableView.backgroundView?.isHidden = true
        }

        return items.count
    }

    // MARK: - UIConfigurable
    override func configureData() {
        super.configureData()

        title = "Donation"
    }

    override func configureStyling() {
        super.configureStyling()
        view.backgroundColor = UIColor.Pallete.White
        modularTableView.separatorStyle = .none
    }

    override func configureLayout() {
        super.configureLayout()

        view.addSubview(actionButton)
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        actionButton.autoPinEdge(toSuperviewEdge: .bottom, withInset: 16)
        actionButton.autoPinEdge(toSuperviewEdge: .leading, withInset: 16)
        actionButton.autoPinEdge(toSuperviewEdge: .trailing, withInset: 16)
    }

    override func configureDelegates() {
        super.configureDelegates()

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
}
