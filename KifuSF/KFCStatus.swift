//
//  KFCStatus.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 07/09/2018.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class KFCStatus: ButtonBarPagerTabStripViewController {
    
    weak var barView: ButtonBarView!
    weak var ownContainerView: UIScrollView!
    var controllerArray = [DeliveryModularTableViewController(), KFCDonation()]
    
    override func viewDidLoad() {
        title = "Status"
        view.backgroundColor = UIColor.Pallete.White
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: .kfFlagIcon,
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(flagButtonPressed))
        setUpTopBar()
        setUpLayout()
        setUpFirebase()
        
        super.viewDidLoad()
    }
    
    @objc func flagButtonPressed() {
        //TODO: flagging
    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        return controllerArray
    }
    
    private func setUpLayout() {
        let barView = ButtonBarView(frame: CGRect(x: 0.0, y: 0.0, width: self.view.bounds.width, height: 50.0),
                                    collectionViewLayout: UICollectionViewFlowLayout())
        let containerView = UIScrollView(frame: CGRect(x: 0, y: 51.0,
                                                       width: self.view.bounds.width,
                                                       height: self.view.bounds.height - 50.0 - 66.0))
        let separatorLine = UIView(frame: CGRect(x: 0.0, y: 50.0,
                                                 width: self.view.bounds.width,
                                                 height: 0.5))
        
        self.barView = barView
        self.ownContainerView = containerView
        separatorLine.backgroundColor = #colorLiteral(red: 0.6941176471, green: 0.6941176471, blue: 0.6941176471, alpha: 1)
        
        view.addSubview(barView)
        view.addSubview(ownContainerView)
        view.addSubview(separatorLine)
        
        barView.translatesAutoresizingMaskIntoConstraints = false
        ownContainerView.translatesAutoresizingMaskIntoConstraints = false
        separatorLine.translatesAutoresizingMaskIntoConstraints = false
        
        barView.autoSetDimension(.height, toSize: 44)
        barView.autoPin(toTopLayoutGuideOf: self, withInset: 0)
        barView.autoPinEdge(toSuperviewEdge: .leading)
        barView.autoPinEdge(toSuperviewEdge: .trailing)
        barView.autoPinEdge(.bottom, to: .top, of: separatorLine)
        
        separatorLine.autoSetDimension(.height, toSize: 0.5)
        separatorLine.autoPinEdge(toSuperviewEdge: .leading)
        separatorLine.autoPinEdge(toSuperviewEdge: .trailing)
        separatorLine.autoPinEdge(.bottom, to: .top, of: ownContainerView)
        
        ownContainerView.autoPinEdge(toSuperviewEdge: .leading)
        ownContainerView.autoPinEdge(toSuperviewEdge: .trailing)
        ownContainerView.autoPin(toBottomLayoutGuideOf: self, withInset: 0)
        
        self.buttonBarView = barView
        self.containerView = ownContainerView
    }
    
    private func setUpTopBar() {
        settings.style.buttonBarBackgroundColor = UIColor.Pallete.White
        settings.style.buttonBarItemBackgroundColor = UIColor.Pallete.White
        settings.style.selectedBarBackgroundColor = UIColor.Pallete.Green
        settings.style.buttonBarItemFont = UIFont.systemFont(ofSize: 14)
        settings.style.selectedBarHeight = 2.0
        settings.style.buttonBarMinimumLineSpacing = 0
        settings.style.buttonBarItemTitleColor = .black
        settings.style.buttonBarItemsShouldFillAvailableWidth = true
        settings.style.buttonBarItemFont = UIFont.preferredFont(forTextStyle: .subheadline)
        
        settings.style.buttonBarLeftContentInset = 0
        settings.style.buttonBarRightContentInset = 0
        
        changeCurrentIndexProgressive = { (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            oldCell?.label.textColor = UIColor.Text.Headline
            newCell?.label.textColor = UIColor.Pallete.Green
        }
    }

    private func setUpFirebase() {
        guard
            let deliveryVc = controllerArray[0] as? DeliveryModularTableViewController,
            let donationVc = controllerArray[1] as? KFCDonation else {
                fatalError("either the indexes of these elements in this array are out of order or the class types have changed for one of the view controllers")
        }
        
        DonationService.observeCurrentDelivery { (delivery) in
            deliveryVc.delivery = delivery
        }
        
        DonationService.observeCurrentDonation { (donation) in
            donationVc.donation = donation
        }
    }
}

extension User {
    var collaboratorInfo: KFMCollaboratorInfo {
        
        //TODO: alex-reputation points
        return KFMCollaboratorInfo(
            profileImageURL: URL(string: self.imageURL) ?? URL.brokenUrlImage,
            name: self.username, //TODO: erick-collect their full name
            username: self.username,
            userReputation: 0,
            userDonationsCount: 0,
            userDeliveriesCount: 0
        )
    }
}

extension Donation {
    var inProgressDescriptionForDonator: KFMInProgressDonationDescription {
        return KFMInProgressDonationDescription(
            imageURL: URL(string: self.imageUrl) ?? URL.brokenUrlImage,
            title: self.title,
            statusDescription: self.status.stringValueForDonator,
            description: self.notes
        )
    }
    
    var inProgressDescriptionForVolunteer: KFMInProgressDonationDescription {
        return KFMInProgressDonationDescription(
            imageURL: URL(string: self.imageUrl) ?? URL.brokenUrlImage,
            title: self.title,
            statusDescription: self.status.stringValueForVolunteer,
            description: self.notes
        )
    }
}

extension Donation.Status {
    var step: KFMProgress.Step {
        switch self {
        case .open:
            return .stepNone
        case .awaitingPickup:
            return .stepOne
        case .awaitingDelivery:
            return .stepTwo
        case .awaitingApproval:
            return .stepThree
        case .awaitingReview:
            return .stepFour
        }
    }
}
