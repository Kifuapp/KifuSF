//
//  KFCRequestedDonations.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 06/09/2018.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import UIKit

class KFCPendingDonations: KFCTableViewWithRoundedCells {

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
        return donations.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let pendingDonationCell = tableView.dequeueReusableCell(
            withIdentifier: KFVRoundedCell<KFVPendingDonation>.identifier,
            for: indexPath
            ) as? KFVRoundedCell<KFVPendingDonation> else {
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
        guard let indexPath = tableViewWithRoundedCells.indexPath(for: sender) else {
            return assertionFailure("no cell found")
        }
        
        let selectedDonation = self.donations[indexPath.row]
        sender.descriptorView.cancelStickyButton.contentView.isEnabled = false
        
        RequestService.cancelRequest(for: selectedDonation) { [unowned self] (isSuccessfull) in
            if isSuccessfull {
                guard let index = self.donations.firstIndex(where: { $0.uid == selectedDonation.uid }) else {
                    return assertionFailure("donation to delete not found")
                }
                
                self.donations.remove(at: index)
                self.tableViewWithRoundedCells.deleteRows(at: [indexPath], with: .right)
            } else {
                sender.descriptorView.cancelStickyButton.contentView.isEnabled = true
            }
        }
    }
}
