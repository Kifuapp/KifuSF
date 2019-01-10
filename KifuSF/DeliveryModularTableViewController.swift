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

class DeliveryModularTableViewController: ModularTableViewController {
    // MARK: - Variables
    var delivery: Donation? {
        didSet {
            updateUI()
        }
    }
    
    override var noDataView: SlideView {
        return SlideView(image: .kfNoDataIcon,
                         title: "No Current Delivery",
                         description: "visit the Open Donations tab to request a delivery")
    }
    
    private let actionButton = UIAnimatedButton(backgroundColor: UIColor.Pallete.Blue,
                                                andTitle: "Directions")
    
    private lazy var photoHelper: PhotoHelper = {
        let helper = PhotoHelper()
        helper.completionHandler = { [weak self] image in
            guard let unwrappedSelf = self else {
                return
            }
            
            guard let delivery = unwrappedSelf.delivery else {
                return assertionFailure("shouldn't select an image without a delivery")
            }
            
            let loadingVc = KFCLoading(style: .whiteLarge)
            loadingVc.present()
            
            DonationService.confirmDelivery(for: delivery, image: image, completion: { (isSuccessful) in
                loadingVc.dismiss {
                    if isSuccessful {
                        unwrappedSelf.delivery?.status = .awaitingReview
                        unwrappedSelf.updateUI()
                    } else {
                        let errorAlert = UIAlertController(errorMessage: nil)
                        unwrappedSelf.present(errorAlert, animated: true)
                    }
                }
            })
        }
        
        return helper
    }()

    // MARK: - Lifecycle
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        var buttonHeight = actionButton.frame.height + 16

        // the first time this view is loaded the height of the button is zero
        // therefore the last tableViewCell is overlaping with the button
        // this is just a temporary workaround
        if actionButton.frame.height == 0 {
            buttonHeight += 44
        }

        modularTableView.contentInset.bottom = buttonHeight
        modularTableView.scrollIndicatorInsets.bottom = buttonHeight
    }

    // MARK: - Methods
    private func updateUI() {
        reloadData()

        //update the actionButton
        actionButton.isHidden = false
        if let delivery = self.delivery {
            switch delivery.status {
            case .open:
                assertionFailure("there shouldn't be a delivery as open here")
            case .awaitingPickup:
                actionButton.setTitle("Directions", for: .normal)
            case .awaitingDelivery:
                actionButton.setTitle("Submit Dropoff", for: .normal)
            case .awaitingApproval:
                assertionFailure("this step should not occur, skip to awaitingReview")
            case .awaitingReview:
                actionButton.setTitle("Submit Review", for: .normal)
            }
        } else {
            actionButton.setTitle("View Open Donations", for: .normal)
        }
    }
    
    override func retrieveProgressItem() -> ModularTableViewItem? {
        guard let deliveryStep = self.delivery?.status.step else {
            return nil
        }
        
        return KFMProgress(currentStep: deliveryStep, ofType: .delivery)
    }
    
    override func retrieveInProgressDonationDescription() -> ModularTableViewItem? {
        guard let deliveryDescription = self.delivery?.inProgressDescriptionForVolunteer else {
            return nil
        }
        
        return deliveryDescription
    }
    
    override func retrieveEntityInfoItem() -> ModularTableViewItem? {
        guard let _ = self.delivery else {
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
    
    override func retrieveCollaboratorInfoItem() -> ModularTableViewItem? {
        guard let donatorInfo = self.delivery?.donator.collaboratorInfo else {
            return nil
        }
        
        return donatorInfo
    }
    
    override func retrieveDestinationMapItem() -> ModularTableViewItem? {
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
            location = CLLocationCoordinate2D(
                latitude: delivery.latitude,
                longitude: delivery.longitude
            )
        } else {
            return nil
        }
        
        return KFMDestinationMap(coordinate: location)
    }
    
    override func didSelect(_ cellType: ModularTableViewController.CellTypes, at indexPath: IndexPath) {
        switch cellType {
        case .destinationMap:
            guard let delivery = self.delivery else {
                return assertionFailure("No delivery given while map was tappable")
            }
            
            if delivery.status.isAwaitingPickup {
                
                //pickup Location
                MapHelper(long: delivery.longitude, lat: delivery.latitude)
                    .open()
            } else if delivery.status.isAwaitingDelivery {
                
                //TODO: charity location
                MapHelper(long: delivery.longitude, lat: delivery.latitude)
                    .open()
            }
        default:
            break
        }
    }
    
    @objc func pressActionButton(_ sender: Any) {
        if let delivery = self.delivery {
            switch delivery.status {
            case .open, .awaitingApproval:
                assertionFailure("delivery should not have this status")
            case .awaitingPickup:
                
                //Directions to pick up loation
                self.openDirectionsToPickUpLocation(for: delivery)
            case .awaitingDelivery:
                
                //Submit Dropoff
                self.presentConfirmationImage(for: delivery)
            case .awaitingReview:
                self.presentReview(for: delivery.donator)
            }
        } else {
            guard let tabBar = self.tabBarController else {
                return assertionFailure("no tabbar found")
            }
            
            tabBar.selectedIndex = 0
        }
    }
    
    private func openDirectionsToPickUpLocation(for delivery: Donation) {
        let map = MapHelper(long: delivery.longitude, lat: delivery.latitude)
        map.open()
    }
    
    private func presentConfirmationImage(for deliver: Donation) {
        photoHelper.presentActionSheet(from: self)
    }
    
    private func presentReview(for user: User) {
        let reviewVc = ReviewCollaboratorViewController()
        reviewVc.donator = user
        reviewVc.delegate = self
        let navReviewVc = UINavigationController(rootViewController: reviewVc)
        present(navReviewVc, animated: true)
    }
    
    private func openDirectionsToCharity(for delivery: Donation) {
        //TODO: erick-find charity location
        let map = MapHelper(long: delivery.longitude, lat: delivery.latitude)
        map.open()
    }

    // MARK: - UIConfigurable
    override func configureStyling() {
        super.configureStyling()
        view.backgroundColor = UIColor.Pallete.White
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
    }
}

// MARK: - IndicatorInfoProvider
extension DeliveryModularTableViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Delivery")
    }
}

// MARK: ReviewCollaboratorViewControllerDelegate
extension DeliveryModularTableViewController: ReviewCollaboratorViewControllerDelegate {
    func review(_ reviewCollaborator: ReviewCollaboratorViewController, didFinishReview review: UserReview) {
        guard let delivery = self.delivery else {
            return assertionFailure("delivery is missing after a review")
        }
        
        DonationService.archive(delivery: delivery, completion: { (isSuccessful) in
            if isSuccessful == false {
                UIAlertController(errorMessage: "Failed to archive the delivery")
                    .present(in: self)
            }
        })
    }
}
