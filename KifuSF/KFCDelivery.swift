//
//  KFCDelivery.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 07/09/2018.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import CoreLocation

class KFCDelivery: KFCModularTableView {
    
    var delivery: Donation? {
        didSet {
            updateUI()
        }
    }

    private let dynamicButton = KFButton(backgroundColor: .kfInformative, andTitle: "Directions")
    
    private func updateUI() {
        reloadData()
    }

    override func loadView() {
        super.loadView()

        view.addSubview(dynamicButton)
        configureLayoutConstraints()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configureStyling()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        modularTableView.contentInset.bottom = dynamicButton.frame.height + 16
        modularTableView.scrollIndicatorInsets.bottom = dynamicButton.frame.height + 16
    }

    override func retrieveProgressItem() -> KFPModularTableViewItem? {
        guard let deliveryStep = self.delivery?.status.step else {
            return nil
        }
        
        return KFMProgress(currentStep: deliveryStep, ofType: .delivery)
    }

    override func retrieveInProgressDonationDescription() -> KFPModularTableViewItem? {
        guard let deliveryDescription = self.delivery?.inProgressDescriptionForVolunteer else {
            return nil
        }
        
        return deliveryDescription
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
        guard let donatorInfo = self.delivery?.donator.collaboratorInfo else {
            return nil
        }
        
        return donatorInfo
    }

    override func retrieveDestinationMapItem() -> KFPModularTableViewItem? {
        guard let delivery = self.delivery else {
            return nil
        }
        
        let location: CLLocationCoordinate2D
        if delivery.status.isAwaitingPickup {
            location = CLLocationCoordinate2D(
                latitude: delivery.latitude,
                longitude: delivery.longitude
            )
        } else if delivery.status.isAwaitingDelivery {
            
            //TODO: get location of selected charity of donation
            return nil
        } else {
            return nil
        }
        
        return KFMDestinationMap(coordinate: location)
    }
}

extension KFCDelivery: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Delivery")
    }
}

//MARK: Styling & LayoutConstraints
extension KFCDelivery {
    private func configureLayoutConstraints() {
        configureDynamicButtonConstraints()
    }

    private func configureStyling() {
        view.backgroundColor = UIColor.kfSuperWhite
    }

    private func configureDynamicButtonConstraints() {
        dynamicButton.translatesAutoresizingMaskIntoConstraints = false
        dynamicButton.autoPinEdge(toSuperviewEdge: .bottom, withInset: 16)
        dynamicButton.autoPinEdge(toSuperviewEdge: .leading, withInset: 16)
        dynamicButton.autoPinEdge(toSuperviewEdge: .trailing, withInset: 16)
    }
}
