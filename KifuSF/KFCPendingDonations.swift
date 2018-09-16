//
//  KFCRequestedDonations.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 06/09/2018.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import UIKit

class KFCPendingDonations: KFCTableViewWithRoundedCells {
    
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
        return 20
        //TODO: return actual amount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let pendingDonationCell = tableView.dequeueReusableCell(withIdentifier: KFVRoundedCell<KFVPendingDonation>.identifier, for: indexPath) as? KFVRoundedCell<KFVPendingDonation> else {
            fatalError(KFErrorMessage.unknownCell)
        }
        
        pendingDonationCell.descriptorView.delegate = self
        
        return pendingDonationCell
    }
}

extension KFCPendingDonations: KFPPendingDonationCellDelegate {
    func didPressButton() {
        print("cancel button pressed")

        //TODO: hook up with firebase
    }
}
