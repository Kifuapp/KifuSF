//
//  HomeViewController.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 27/08/2018.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import UIKit

enum DonationOption: SwitchlessCases {

    // sourcery: case_skip
    case none

    // sourcery: case_name = "isShowingPendingRequests"
    case pendingRequests([Donation])

    // sourcery: case_name = "isShowingCurrentDelivery"
    case deliveringDonation(Donation)
}

class KFCOpenDonations: TableViewWithRoundedCellsViewController {

    private var openDonations: [Donation] = [] {
        didSet {
            tableViewWithRoundedCells.reloadData()
        }
    }


    /** updated by firebase observe a method */
    private var currentDonation: Donation?
    
    /** updated by firebase observe a method */
    private var currentDelivery: Donation?
    
    /** updated by firebase observe a method */
    private var pendingRequests: [Donation] = []
    
    private var currentDeliveryState: DonationOption {
        if let donation = currentDelivery {
            return .deliveringDonation(donation)
        } else {
            if pendingRequests.count == 0 {
                return .none
            } else {
                return .pendingRequests(pendingRequests)
            }
        }
    }

    private var lastSelectedCell: RoundedTableViewCell<KFVDonationInfo>?
    private var widgetView = KFVWidget()

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        UserService.login(email: "e@g.com", password: "password") { (user) in
//            guard let user = user else {
//                return
//            }
//
//            User.setCurrent(user, writeToUserDefaults: true)
//        }

        tableViewWithRoundedCells.dataSource = self
        tableViewWithRoundedCells.delegate = self

        configureWidgetView()
        configureDonationTableView()
        configureNavBar()
        configureFirebase()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableViewWithRoundedCells.reloadData()

//        widgetView?.reloadData()

    }

    func configureFirebase() {
        DonationService.observeTimelineDonations { (donations) in
            self.openDonations = donations
        }
        
        DonationService.observeCurrentDelivery { (delivery) in
            self.currentDelivery = delivery
            self.widgetView.reloadData()
        }
        
        DonationService.observeCurrentDonation { (donation) in
            self.currentDonation = donation
            self.widgetView.reloadData()
        }
        
        RequestService.observePendingRequests(completion: { (donationsUserHadRequestedToDeliver) in
            if self.currentDeliveryState.isShowingCurrentDelivery == false {
                self.pendingRequests = donationsUserHadRequestedToDeliver
                
                self.widgetView.reloadData()
            }
        })
    }

    @objc func createDonation() {
        guard self.currentDonation == nil else {
            UIAlertController(errorMessage: "You cannot create another donation while having a donation in progress. Please complete your current donation before creating another.")
                .present(in: self)
            
            return
        }
        
        let createDonationViewController = UINavigationController(rootViewController: CreateDonationViewController())
        createDonationViewController.modalTransitionStyle = .coverVertical
        present(createDonationViewController, animated: true)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let id = segue.identifier else {
            fatalError(KFErrorMessage.unknownIdentifier)
        }

        switch id {
        case UIStoryboardSegue.kfShowDetailedDonation:

            //TODO: fix this crap
            //Victor: Hayir

            if let cell = lastSelectedCell {
                cell.setSelected(false, animated: true)
            }
        default:
            fatalError(KFErrorMessage.unknownIdentifier)
        }
    }

}

//MARK: UITableViewDataSource
extension KFCOpenDonations: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.openDonations.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let donationCell = tableView.dequeueReusableCell(withIdentifier: RoundedTableViewCell<KFVDonationInfo>.identifier) as? RoundedTableViewCell<KFVDonationInfo> else {
            fatalError(KFErrorMessage.unknownCell)
        }

        let openDonation = self.openDonations[indexPath.row]

        let distance = UserService.calculateDistance(donation: openDonation)
        let newData = KFMDonationInfo(
            imageURL: URL(string: openDonation.imageUrl)!,
            title: openDonation.title,
            distance: distance,
            description: openDonation.notes
        )
        donationCell.descriptorView.reloadData(for: newData)

        return donationCell
    }
}

extension KFCOpenDonations: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? RoundedTableViewCell<KFVDonationInfo> else {
            fatalError(KFErrorMessage.unknownCell)
        }

        lastSelectedCell = cell

        let selectedDonation = self.openDonations[indexPath.row]
        let detailedOpenDonationVC = DetailedDonationModularTableViewController()
        detailedOpenDonationVC.donation = selectedDonation
        
//        switch self.currentDeliveryState {
//        case .pendingRequests(let requestedDonations):
//            if requestedDonations.contains(selectedDonation) {
//                detailedOpenDonationVC.userRequestingStatus = .userHasRequested
//            }
//        case .deliveringDonation:
//            detailedOpenDonationVC.userRequestingStatus = .userAlreadyHasCurrentDelivery
//        default:
//            break
//        }
        navigationController?.pushViewController(detailedOpenDonationVC, animated: true)
    }
}

//MARK: KFPWidgetDataSource
extension KFCOpenDonations: KFPWidgetDataSource {
    func widgetView(_ widgetView: KFVWidget, cellInfoForType type: KFVWidget.TouchedViewType) -> KFPWidgetInfo? {
        switch type {
        case .donation:
            guard let donation = self.currentDonation else {
                return nil
            }

            let descriptor = KFMWidgetDescriptor(for: donation)

            return descriptor.forDonator()
        case .delivery:
            switch self.currentDeliveryState {
            case .none:
                return nil
            case .pendingRequests(let pendingDonations):
                let nRequests = pendingDonations.count

                return KFMWidgetDescriptor.Descriptor(
                    title: "Your Delivery",
                    subtitle: "Pending Requests (\(nRequests))"
                )
            case .deliveringDonation(let delivery):
                let descriptor = KFMWidgetDescriptor(for: delivery)

                return descriptor.forVolunteer()
            }
        }
    }
}

//MARK: KFPWidgetDelegate
extension KFCOpenDonations: KFPWidgetDelegate {

    func widgetView(_ widgetView: KFVWidget, didSelectCellForType type: KFVWidget.TouchedViewType) {

        switch type {
        case .donation:
            guard let donation = self.currentDonation else {
                fatalError("the widget view needs to be hidden if there is no current donation")
            }
            
            
            switch donation.status {
            case .open:
                
                //fetch user objects for the given donation
                RequestService.retrieveVolunteers(for: donation) { (volunteers) in
                    let volunteersListVC = KFCVolunteerList()
                    volunteersListVC.volunteers = volunteers
                    volunteersListVC.donation = donation
                    self.navigationController?.pushViewController(volunteersListVC, animated: true)
                }
            default:
                
                //TODO: question-should selecting this only switch tabs?
                guard let tabbarVc = self.tabBarController else {
                    fatalError("no tab bar controller in this vc")
                }
                
                tabbarVc.selectedIndex = 1
            }

        case .delivery:
            switch self.currentDeliveryState {
            case .pendingRequests(let pendingDonations):
                let pendingDonationsVC = KFCPendingDonations()
                pendingDonationsVC.donations = pendingDonations
                navigationController?.pushViewController(pendingDonationsVC, animated: true)
            case .deliveringDonation:

                //TODO: question-should selecting this only switch tabs?
                guard let tabbarVc = self.tabBarController else {
                    fatalError("no tab bar controller in this vc")
                }

                tabbarVc.selectedIndex = 1
            case .none:
                fatalError("widget view should be hidden if there are no pending requests or a current delivery")
            }
        }
    }
}

extension KFCOpenDonations {

    func configureWidgetView() {
        widgetView.dataSource = self
        widgetView.delegate = self

        view.addSubview(widgetView)
        configureWidgetViewLayoutConstraints()

        widgetView.reloadData()
    }

    func configureWidgetViewLayoutConstraints() {
        widgetView.translatesAutoresizingMaskIntoConstraints = false

        widgetView.autoPinEdge(toSuperviewEdge: .top)
        widgetView.autoPinEdge(toSuperviewEdge: .leading)
        widgetView.autoPinEdge(toSuperviewEdge: .trailing)
    }

    func configureDonationTableView() {
        tableViewWithRoundedCells.dataSource = self
        tableViewWithRoundedCells.delegate = self

        tableViewWithRoundedCells.register(RoundedTableViewCell<KFVDonationInfo>.self, forCellReuseIdentifier: RoundedTableViewCell<KFVDonationInfo>.identifier)

        configureDonationTableViewConstraints()
    }

    func configureDonationTableViewConstraints() {
        for constraint in tableViewWithRoundedCellsConstraints {
            constraint.autoRemove()
        }

        tableViewWithRoundedCells.autoPinEdge(.top, to: .bottom, of: widgetView)
        tableViewWithRoundedCells.autoPinEdge(toSuperviewEdge: .bottom)
        tableViewWithRoundedCells.autoPinEdge(toSuperviewEdge: .leading)
        tableViewWithRoundedCells.autoPinEdge(toSuperviewEdge: .trailing)
    }

    func configureNavBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: .kfPlusIcon,
            style: .plain,
            target: self,
            action: #selector(createDonation)
        )
        
        title = "Home"
    }
}
