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

class HomeViewController: UIViewController {
    
    @IBOutlet weak var donationsTableView: UITableView!
    
    private var openDonations: [Donation] = [] {
        didSet {
            donationsTableView.reloadData()
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
    
    private var lastSelectedCell: KFVDonationCell?
    private var widgetView: KFVWidget?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpWidgetView()
        setUpDonationTableView()
        setUpNavBar()
        setUpFirebase()
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        widgetView?.reloadData()
        
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
            
            //TODO: update widget view
        }
        
        RequestService.observePendingRequests(completion: { (donationsUserHadRequestedToDeliver) in
            if self.currentDeliveryState.isShowingCurrentDelivery == false {
                self.pendingRequests = donationsUserHadRequestedToDeliver
                
                //TODO: update widget view
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
        case KFSegue.showDetailedDonation:
            
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
extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
        
        //TODO: return the actual amount of cells
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let donationCell = donationsTableView.dequeueReusableCell(withIdentifier: KFVDonationCell.reuseIdentifier) as? KFVDonationCell else {
            fatalError(KFErrorMessage.unknownCell)
        }

        return donationCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 152
    }
}

extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = donationsTableView.cellForRow(at: indexPath) as? KFVDonationCell else {
            fatalError(KFErrorMessage.unknownCell)
        }
        lastSelectedCell = cell
        
        performSegue(withIdentifier: KFSegue.showDetailedDonation, sender: self)
    }
    
}

//MARK: KFPWidgetDataSource
extension HomeViewController: KFPWidgetDataSource {
    func widgetView(_ widgetView: KFVWidget, cellInfoForType type: KFVWidget.TouchedViewType) -> KFPWidgetInfo {
        switch type {
        case .donation(_):
            return KFVWidget.KFMWidgetInfo(title: "Toilet Paper", subtitle: "Current Step")
        case .delivery(_):
            return KFVWidget.KFMWidgetInfo(title: "Toilet Paper", subtitle: "Current Step")
        }
    }
    
    
}

//MARK: KFPWidgetDelegate
extension HomeViewController: KFPWidgetDelegate {
    func widgetView(_ widgetView: KFVWidget, didSelectCellForType type: KFVWidget.TouchedViewType) {
        
        switch type {
        case .donation(_):
            print("Donation widget pressed")
        case .delivery(_):
            print("Delivery widget pressed")
        }
    }
    
    
}

extension HomeViewController {
    
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
        
        widgetView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        widgetView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        widgetView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
    }
    
    func setUpDonationTableView() {
        donationsTableView.dataSource = self
        donationsTableView.delegate = self
        
        donationsTableView.separatorStyle = .none
        
        let donationTableViewCell = UINib(nibName: KFVDonationCell.nibName, bundle: nil)
        donationsTableView.register(donationTableViewCell, forCellReuseIdentifier: KFVDonationCell.reuseIdentifier)
        
        donationsTableView.registerTableViewCell(for: KFVDonationCell.self)
    }
    
    func setUpNavBar() {
        navigationController?.tabBarItem.image = KFImage.boxIcon
        navigationController?.tabBarItem.title = "Home"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(createDonation))
        title = "Home"
        
        
        
        //MARK: Some random attempt to create the same blur effect between widget view and nav bar
        
        //        self.navigationController?.navigationBar.isTranslucent = true
        //        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        //
        //        var bounds = navigationController!.navigationBar.bounds
        //        bounds.size.height += 20
        //        bounds.origin.y -= 20
        //
        //        let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .light))
        //        visualEffectView.isUserInteractionEnabled = false
        //        visualEffectView.frame = bounds
        //        visualEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        //
        //        self.navigationController?.navigationBar.addSubview(visualEffectView)
        //        visualEffectView.layer.zPosition = -1
    }
}
