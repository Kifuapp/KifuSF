//
//  KFCRequestedDonations.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 06/09/2018.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import UIKit

class KFCPendingDonations: KFCTableViewWithRoundedCells {
    
    //TODO: remove this
    var numberOfRows = 20
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Requested Donations"
        
        tableView.register(KFVRoundedCell<KFVPendingDonation>.self, forCellReuseIdentifier: KFVRoundedCell<KFVPendingDonation>.identifier)
        
        tableView.dataSource = self
        tableView.allowsSelection = false
    }
}

extension KFCPendingDonations: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfRows
        //TODO: return actual amount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let pendingDonationCell = tableView.dequeueReusableCell(withIdentifier: KFVRoundedCell<KFVPendingDonation>.identifier, for: indexPath) as? KFVRoundedCell<KFVPendingDonation> else {
            fatalError(KFErrorMessage.unknownCell)
        }
        
        //TODO: self-explanatory
        let newData = KFMPendingDonation(imageURL: URL(string: "https://images.pexels.com/photos/356378/pexels-photo-356378.jpeg?auto=compress&cs=tinysrgb&h=350")!, title: "Doggo", distance: 3.14)
        pendingDonationCell.descriptorView.reloadData(for: newData)
        pendingDonationCell.descriptorView.delegate = self
        
        return pendingDonationCell
    }
}

extension KFCPendingDonations: KFPPendingDonationCellDelegate {
    func didPressButton(_ sender: KFVRoundedCell<KFVPendingDonation>) {
        let indexPath = tableView.indexPath(for: sender)
        
        print(indexPath)
        numberOfRows -= 1
        tableView.deleteRows(at: [indexPath!], with: .fade)
    }
}
