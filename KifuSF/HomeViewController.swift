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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.tabBarItem.title = "Home"
        navigationItem.title = "Donations"
        
        donationsTableView.dataSource = self
        donationsTableView.delegate = self
        
        donationsTableView.separatorStyle = .none
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //TODO: retrieve open donations in viewDidLoad maybe?
        DonationService.showTimelineDonations { (donations) in
            self.openDonations = donations
        }
    }

}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return openDonations.count
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let donationCell = donationsTableView.dequeueReusableCell(withIdentifier: "donationCell") as? DonationTableViewCell else {
            fatalError("unknown donation table view cell")
        }
        
        
        
        return donationCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    
}

extension HomeViewController: UITableViewDelegate {
    
}
