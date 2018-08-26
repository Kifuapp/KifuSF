//
//  ItemListViewController.swift
//  KifuSF
//
//  Created by Shutaro Aoyama on 2018/07/28.
//  Copyright © 2018年 Alexandru Turcanu. All rights reserved.
//

import UIKit
import CoreLocation
import LocationPicker

class ItemListViewController: UIViewController {
    
    private var currentDonation: Donation?
    
    private enum DonationOption {
        case none
        case pendingRequests([Donation])
        case deliveringDonation(Donation)
        
        enum Errors: Error {
            case invokedMethodWithWrongCase
        }
        
        var isShowingPendingRequests: Bool {
            if case .pendingRequests = self {
                return true
            }
            
            return false
        }
        
        func pendingRequests() throws -> [Donation] {
            switch self {
            case .pendingRequests(let pendingDonations):
                return pendingDonations
            default:
                throw Errors.invokedMethodWithWrongCase
            }
        }
        
        var isShowingCurrentDelivery: Bool {
            if case .deliveringDonation = self {
                return true
            }
            
            return false
        }
        
        func deliveringDonation() throws -> Donation {
            switch self {
            case .deliveringDonation(let donation):
                return donation
            default:
                throw Errors.invokedMethodWithWrongCase
            }
        }
    }
    private var currentDelivery: DonationOption = .none
    
    private var openDonations: [Donation] = [] {
        didSet {
            postTable.reloadData()
        }
    }
    private var locationManager: CLLocationManager!
    private var currentLocation: CLLocationCoordinate2D?
    
    // MARK: - RETURN VALUES
    
    // MARK: - VOID METHODS
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            switch identifier {
            case "show detailed donation":
                guard
                    let cell = sender as? UITableViewCell,
                    let indexPath = postTable.indexPath(for: cell),
                    let itemDetailVc = segue.destination as? ItemDetailViewController else {
                        fatalError("storyboard not set up correctly")
                }
                
                let selectedDonation = openDonations[indexPath.row]
                itemDetailVc.donation = selectedDonation
            case "show pending requests":
                guard let pendingRequestsVc = segue.destination as? PendingRequestsViewController else {
                        fatalError("storyboard not set up correctly")
                }
                
                pendingRequestsVc.pendingDonations = try! currentDelivery.pendingRequests() // swiftlint:disable:this force_try
            default: break
            }
        }
    }
    
    private func updateBanner() {
        if let donatingDonation = self.currentDonation { 
            stackViewDonation.isHidden = false
            labelDonationHeader.text = "Donation - \(donatingDonation.title)"
            labelDonationBody.text = donatingDonation.status.stringValueForDonator
        } else {
            stackViewDonation.isHidden = true
        }
        
        switch self.currentDelivery {
        case .none:
            stackViewDelivery.isHidden = true
        case .pendingRequests(let pendingDonationRequests):
            if pendingDonationRequests.count > 0 {
                stackViewDelivery.isHidden = false
                labelDeliveryHeader.text = "Pending Delivery Requests"
                labelDeliveryBody.text = "\(pendingDonationRequests.count) open request(s)"
            } else {
                stackViewDelivery.isHidden = true
            }
        case .deliveringDonation(let deliveryingDonation):
            stackViewDelivery.isHidden = false
            labelDeliveryHeader.text = deliveryingDonation.title
            labelDeliveryBody.text = deliveryingDonation.status.stringValueForVolunteer
        }
        
        //hide banner if both donation and deliveries are empty
        viewBanner.isHidden = stackViewDonation.isHidden && stackViewDelivery.isHidden
        
        //update table view top inset
        let topPadding = viewBanner.frame.height
        postTable.contentInset.top = topPadding
        postTable.scrollIndicatorInsets.top = topPadding
    }
    
    // MARK: - IBACTIONS
    @IBOutlet weak var postTable: UITableView!
    
    @IBOutlet weak var viewBanner: UIView!
    @IBOutlet weak var stackViewDonation: UIStackView!
    @IBAction func pressDonationBanner(_ sender: Any) {
        guard let tabbarVc = self.tabBarController else {
            fatalError("no tab bar controller")
        }
        
        //TODO: select Donation Subtab
        tabbarVc.selectedIndex = 1
    }
    
    @IBOutlet weak var labelDonationHeader: UILabel!
    @IBOutlet weak var labelDonationBody: UILabel!
    @IBOutlet weak var stackViewDelivery: UIStackView!
    @IBAction func pressDeliveryBanner(_ sender: Any) {
        guard let tabbarVc = self.tabBarController else {
            fatalError("no tab bar controller")
        }
        
        if currentDelivery.isShowingPendingRequests {
            performSegue(withIdentifier: "show pending requests", sender: nil)
        } else {
            
            //TODO: select Delivery Subtab
            tabbarVc.selectedIndex = 1
        }
    }
    
    @IBOutlet weak var labelDeliveryHeader: UILabel!
    @IBOutlet weak var labelDeliveryBody: UILabel!
    
    // MARK: - LIFE CYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager = CLLocationManager()
        locationManager.requestWhenInUseAuthorization()
        
        DonationService.observeOpenDontationAndDelivery { (donation, delivery) in
            self.currentDonation = donation
            if delivery != nil {
                self.currentDelivery = .deliveringDonation(delivery!)
                
                self.updateBanner()
            } else {
                RequestService.getPendingRequests(completion: { (donationsUserHadRequestedToDeliver) in
                    self.currentDelivery = .pendingRequests(donationsUserHadRequestedToDeliver)
                    
                    self.updateBanner()
                })
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        DonationService.showTimelineDonations { [weak self] (donations) in
            self?.openDonations = donations
        }
    }

}

extension ItemListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return openDonations.count //return number of posts
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let postCell = postTable.dequeueReusableCell(withIdentifier: "postCell") as! ItemPostCell
        
        let donation = openDonations[indexPath.row]
        postCell.itemName.text = donation.title
        
        postCell.itemImage.kf.setImage(with: URL(string: donation.imageUrl)!)
        postCell.postInfo.text = "@\(donation.donator.username)"
        
        let distanceTitle = UserService.calculateDistance(long: donation.longitude, lat: donation.laditude)
        postCell.distance.text = distanceTitle
        
        return postCell
    }
}

extension ItemListViewController: UITableViewDelegate {
    
}
