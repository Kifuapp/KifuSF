//
//  HomeViewController.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 27/08/2018.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import UIKit

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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpWidgetView()
        setUpDonationTableView()
        setUpNavBar()
        setUpFirebase()
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //TODO: retrieve open donations in viewDidLoad maybe?
        DonationService.showTimelineDonations { (donations) in
            self.openDonations = donations
        }
    
    }
    
    func setUpFirebase() {
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
    }

}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
        
        //TODO: return the actual amount of cells
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let donationCell = donationsTableView.dequeueReusableCell(withIdentifier: KFDonationTableViewCell.reuseIdentifier) as? KFDonationTableViewCell else {
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
        performSegue(withIdentifier: KFSegue.showDetailedDonation, sender: self)
    }
}
