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

class KFCOpenDonations: KFCTableViewWithRoundedCells {
    
    private var openDonations: [Donation] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    private var currentDonation: Donation?
    private var pendingRequests: [Donation] = []
    private var currentDelivery: Donation?
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
    
    private var lastSelectedCell: KFVRoundedCell<KFVDonationInfo>?
    private var widgetView: KFVWidget?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        
        
        setUpDonationTableView()
        setUpWidgetView()
        setUpNavBar()
        setUpFirebase()
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        
//        widgetView?.reloadData()
        
        //TODO: retrieve open donations in viewDidLoad maybe?
        /*
        DonationService.showTimelineDonations { (donations) in
            self.openDonations = donations
        }
        */
    
    }
    
    func setUpFirebase() {
        /*
        DonationService.observeOpenDonationAndDelivery { (donation, delivery) in
            self.currentDonation = donation
            self.currentDelivery = delivery
            
             widgetView?.reloadData()
        }
        
        RequestService.observePendingRequests(completion: { (donationsUserHadRequestedToDeliver) in
            if self.currentDeliveryState.isShowingCurrentDelivery == false {
                self.pendingRequests = donationsUserHadRequestedToDeliver
                
                 widgetView?.reloadData()
            }
        })
        */
    }
    
    @objc func createDonation() {
        //TODO: segue to create donation VC
        
        let createDonationStoryboard = UIStoryboard(name: "CreateDonation", bundle: nil)
        if let createDonationVC = createDonationStoryboard.instantiateInitialViewController() {
            present(createDonationVC, animated: true)
        } else {
            print("error")
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let id = segue.identifier else {
            fatalError(KFErrorMessage.unknownIdentifier)
        }
        
        switch id {
        case UIStoryboardSegue.kfShowDetailedDonation:
            
            //TODO: fix this crap
            
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
        return 10
        
        //TODO: return the actual amount of cells
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let donationCell = tableView.dequeueReusableCell(withIdentifier: KFVRoundedCell<KFVDonationInfo>.identifier) as? KFVRoundedCell<KFVDonationInfo> else {
            fatalError(KFErrorMessage.unknownCell)
        }
        
        //TODO: self explanatory
        let newData = KFMDonationInfo(imageURL: URL(string: "https://images.pexels.com/photos/356378/pexels-photo-356378.jpeg?auto=compress&cs=tinysrgb&h=350")!, title: "Doggo", distance: 12.3, description: "woof woof")
        donationCell.descriptorView.reloadData(for: newData)

        return donationCell
    }
}

extension KFCOpenDonations: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? KFVRoundedCell<KFVDonationInfo> else {
            fatalError(KFErrorMessage.unknownCell)
        }
        
        lastSelectedCell = cell
        
        let detailedOpenDonationVC = KFCDetailedDonation()
        navigationController?.pushViewController(detailedOpenDonationVC, animated: true)
    }
    
}

//MARK: KFPWidgetDataSource
extension KFCOpenDonations: KFPWidgetDataSource {
    func widgetView(_ widgetView: KFVWidget, cellInfoForType type: KFVWidget.TouchedViewType) -> KFPWidgetInfo? {
        switch type {
        case .donation(_):
            return KFVWidget.KFMWidgetInfo(title: "Toilet Paper", subtitle: "Current Step")
        case .delivery(_):
            return KFVWidget.KFMWidgetInfo(title: "Toilet Paper", subtitle: "Current Step")
        }
    }
    
    
}

//MARK: KFPWidgetDelegate
extension KFCOpenDonations: KFPWidgetDelegate {
    func widgetView(_ widgetView: KFVWidget, heightDidChange height: CGFloat) {
        tableView.contentInset.top = height + 8
        tableView.scrollIndicatorInsets.top = height + 8
    }
    
    func widgetView(_ widgetView: KFVWidget, didSelectCellForType type: KFVWidget.TouchedViewType) {
        
        switch type {
        case .donation(_):
            print("Donation widget pressed")
            
            let volunteersListVC = KFCVolunteerList()
            navigationController?.pushViewController(volunteersListVC, animated: true)
            
        case .delivery(_):
            print("Delivery widget pressed")
            
            let pendingDonationsVC = KFCPendingDonations()
            navigationController?.pushViewController(pendingDonationsVC, animated: true)
        }
    }
}

extension KFCOpenDonations {
    
    func setUpWidgetView() {
        guard let widgetView = Bundle.main.loadNibNamed(KFVWidget.nibName, owner: self, options: nil)?.first as? KFVWidget else {
            assertionFailure(KFErrorMessage.nibFileNotFound)
            return
        }
        
        self.widgetView = widgetView
        
        widgetView.dataSource = self
        widgetView.delegate = self
        
        view.addSubview(widgetView)

        widgetView.translatesAutoresizingMaskIntoConstraints = false

        widgetView.autoPinEdge(toSuperviewEdge: .top)
        widgetView.autoPinEdge(toSuperviewEdge: .leading)
        widgetView.autoPinEdge(toSuperviewEdge: .trailing)

        widgetView.reloadData()
    }
    
    func setUpDonationTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(KFVRoundedCell<KFVDonationInfo>.self, forCellReuseIdentifier: KFVRoundedCell<KFVDonationInfo>.identifier)
    }
    
    func setUpNavBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(createDonation))
        title = "Home"
    }
}
