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
    
    var donations: [Donation]!

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Requested Donations"

        tableViewWithRoundedCells.register(
          KFVRoundedCell<KFVPendingDonation>.self,
          forCellReuseIdentifier: KFVRoundedCell<KFVPendingDonation>.identifier
          )

        tableViewWithRoundedCells.dataSource = self
        tableViewWithRoundedCells.allowsSelection = false
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

        let donation = self.donations[indexPath.row]
        let donationDistance: Double = 0
        let data = KFMPendingDonation(
            imageURL: URL(string: donation.imageUrl)!,
            title: donation.title,
            distance: donationDistance
        )
        pendingDonationCell.descriptorView.reloadData(for: data)
        pendingDonationCell.descriptorView.delegate = self

        return pendingDonationCell
    }
}

extension KFCPendingDonations: KFPPendingDonationCellDelegate {
    func didPressButton(_ sender: KFVRoundedCell<KFVPendingDonation>) {
        let indexPath = tableViewWithRoundedCells.indexPath(for: sender)

        numberOfRows -= 1
        tableViewWithRoundedCells.deleteRows(at: [indexPath!], with: .fade)
    }
}
