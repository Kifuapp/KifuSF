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

    let actionButton = KFButton(backgroundColor: .kfInformative, andTitle: "Directions")
    
    private func updateUI() {
        reloadData()
    }

    override func loadView() {
        super.loadView()

        view.addSubview(actionButton)
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        actionButton.autoPinEdge(toSuperviewEdge: .bottom, withInset: 16)
        actionButton.autoPinEdge(toSuperviewEdge: .leading, withInset: 16)
        actionButton.autoPinEdge(toSuperviewEdge: .trailing, withInset: 16)
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
        guard let donationStep = self.donation?.status.step else {
            return nil
        }
        
        return KFMProgress(currentStep: donationStep, ofType: .delivery)
    }

    override func retrieveInProgressDonationDescription() -> KFPModularTableViewItem? {
        guard let donationDescription = self.donation?.inProgressDescriptionForDonator else {
            return nil
        }
        
        return donationDescription
    }

    override func retrieveEntityInfoItem() -> KFPModularTableViewItem? {
        guard let delivery = self.delivery else {
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
}

extension KFCDonation: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Donation")
    }
}
