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
    
    let dynamicButton = KFVButton(backgroundColor: .kfInformative, andTitle: "Directions")
    
    override func loadView() {
        super.loadView()
        
        view.addSubview(dynamicButton)
        dynamicButton.translatesAutoresizingMaskIntoConstraints = false
        dynamicButton.autoPinEdge(toSuperviewEdge: .bottom, withInset: 16)
        dynamicButton.autoPinEdge(toSuperviewEdge: .leading, withInset: 16)
        dynamicButton.autoPinEdge(toSuperviewEdge: .trailing, withInset: 16)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.kfWhite
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        modularTableView.contentInset.bottom = dynamicButton.frame.height + 16
        modularTableView.scrollIndicatorInsets.bottom = dynamicButton.frame.height + 16
    }
    
    override func retrieveProgressItem() -> KFPModularTableViewItem? {
        return KFMProgress(currentStep: .stepOne, ofType: .delivery)
    }
    
    override func retrieveInProgressDonationDescription() -> KFPModularTableViewItem? {
        return KFMInProgressDonationDescription(imageURL: URL(string: "https://images.pexels.com/photos/356378/pexels-photo-356378.jpeg?auto=compress&cs=tinysrgb&h=350")!, title: "Toilet Paper", statusDescription: "Picking up Item", description: "woof woof")
    }
    
    override func retrieveEntityInfoItem() -> KFPModularTableViewItem? {
        return KFMEntityInfo(name: "Make School", phoneNumber: "+1 (415) 814-0980", address: "1547 Mission St San Francisco, CA  94103", entityType: .charity)
    }
    
    override func retrieveCollaboratorInfoItem() -> KFPModularTableViewItem? {
        return KFMCollaboratorInfo(profileImageURL: URL(string: "https://images.pexels.com/photos/356378/pexels-photo-356378.jpeg?auto=compress&cs=tinysrgb&h=350")!, name: "Alexandru Turcanu", username: "Pondorasti", userReputation: 100.0, userDonationsCount: 99, userDeliveriesCount: 99)
    }
    
    override func retrieveDestinationMapItem() -> KFPModularTableViewItem? {
        return KFMDestinationMap(coordinate: CLLocationCoordinate2D(latitude: 0, longitude: 0))
    }
}

extension KFCDonation: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Donation")
    }
}
