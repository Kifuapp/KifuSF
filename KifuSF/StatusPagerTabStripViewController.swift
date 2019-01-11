//
//  KFCStatus.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 07/09/2018.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class StatusPagerTabStripViewController: ButtonBarPagerTabStripViewController {
    // MARK: - Variables
    weak var barView: ButtonBarView!
    weak var ownContainerView: UIScrollView!

    private let deliveryModularTableViewController = DeliveryModularTableViewController()
    private let donationModularTableViewController = DonationModularTableViewController()
    var controllerArray = [ModularTableViewController]()

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        controllerArray = [deliveryModularTableViewController, donationModularTableViewController]

        configureData()
        configureDelegates()
        configureStyling()
        configureLayout()
        configureFireBase()

        super.viewDidLoad()
    }

    // MARK: - Methods
    @objc func flagButtonPressed() {
        let user: User?
        let donation: Donation?
        var title = "Is there anything wrong with this "

        if currentIndex == 0 {
            title += "delivery"

            user = deliveryModularTableViewController.delivery?.donator
            donation = deliveryModularTableViewController.delivery
        } else {
            title += "donation"

            user = donationModularTableViewController.donation?.donator
            donation = donationModularTableViewController.donation
        }

        let flaggingViewController = UINavigationController(
            rootViewController: FlaggingViewController(
                flaggableItems: flaggableItems,
                userToReport: user,
                donationToReport: donation
            )
        )

        let alertController = UIAlertController(
            title: title,
            message: nil,
            preferredStyle: .actionSheet
        )

        alertController.addButton(
            title: "Report Donation",
            style: .default) { (_) in
                self.present(flaggingViewController, animated: true)
        }
        alertController.addCancelButton()
        present(alertController, animated: true)
    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        return controllerArray
    }
}

extension StatusPagerTabStripViewController: FlaggingContentItems {
    var flaggableItems: [FlaggedContentType] {
        return [
            .flaggedImage,
            .flaggedNotes,
            .flaggedPickupLocation,
            .flaggedPhoneNumber,
            .flaggedCommunication
        ]
    }
}

// MARK: - User
extension User {
    var collaboratorInfo: KFMCollaboratorInfo {
        return KFMCollaboratorInfo(
            profileImageURL: URL(string: self.imageURL) ?? URL.brokenUrlImage,
            name: self.username, //TODO: erick-collect their fullname
            username: self.username,
            userReputation: self.reputation,
            userDonationsCount: self.numberOfDonations,
            userDeliveriesCount: self.numberOfDeliveries
        )
    }
}

// MARK: - Donation
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

// MARK: - Donation.Status
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

extension StatusPagerTabStripViewController: UIConfigurable {
    func configureDelegates() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: .kfFlagIcon,
            style: .plain,
            target: self,
            action: #selector(flagButtonPressed)
        )

        changeCurrentIndexProgressive = { (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            oldCell?.label.textColor = UIColor.Text.Headline
            newCell?.label.textColor = UIColor.Pallete.Green
        }
    }

    private func configureFireBase() {
        guard
            let deliveryVc = controllerArray[0] as? DeliveryModularTableViewController,
            let donationVc = controllerArray[1] as? DonationModularTableViewController else {
                fatalError("either the indexes of these elements in this array are out of order or the class types have changed for one of the view controllers")
        }

        DonationService.observeCurrentDelivery { (delivery) in
            deliveryVc.delivery = delivery
        }

        DonationService.observeCurrentDonation { (donation) in
            donationVc.donation = donation
        }
    }

    func configureData() {
        title = "Status"
    }

    func configureStyling() {
        view.backgroundColor = UIColor.Pallete.White

        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()

        configureSettingsStyling()
    }

    func configureSettingsStyling() {
        settings.style.buttonBarBackgroundColor = UIColor.Pallete.White
        settings.style.selectedBarBackgroundColor = UIColor.Pallete.Green
        settings.style.buttonBarItemBackgroundColor = UIColor.Pallete.White

        settings.style.selectedBarHeight = 2.0
        settings.style.buttonBarMinimumLineSpacing = 0
        settings.style.buttonBarItemTitleColor = .black
        settings.style.buttonBarItemsShouldFillAvailableWidth = true

        settings.style.buttonBarItemFont = UIFont.systemFont(ofSize: 14)
        settings.style.buttonBarItemFont = UIFont.preferredFont(forTextStyle: .subheadline)

        settings.style.buttonBarLeftContentInset = 0
        settings.style.buttonBarRightContentInset = 0
    }

    func configureLayout() {
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
}
