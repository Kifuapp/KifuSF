//
//  PendingRequestsViewController.swift
//  KifuSF
//
//  Created by Erick Sanchez on 8/25/18.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import UIKit

class PendingRequestsViewController: UITableViewController {
    
    // MARK: - VARS
    
    var pendingDonations: [Donation]!
    
    // MARK: - RETURN VALUES
    
    // MARK: - METHODS
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            switch identifier {
            case "show detailed donation":
                guard
                    let cell = sender as? UITableViewCell,
                    let indexPath = tableView.indexPath(for: cell) else {
                        fatalError("\"show detailed donation\" was performed by not a cell")
                }
                
                guard let donationDetailVc = segue.destination as? ItemDetailViewController else {
                    fatalError("storyboard not set up correctly")
                }
                
                let selectedDonation = pendingDonations[indexPath.row]
                donationDetailVc.donation = selectedDonation
            default: break
            }
        }
    }
    
    // MARK: - IBACTIONS
    
    // MARK: - LIFE CYCLE

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pendingDonations.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pending donation cell", for: indexPath) as! PendingDonationTableViewCell
        
        let donation = pendingDonations[indexPath.row]
        cell.configure(donation)
        cell.delegate = self
        
        return cell
    }
}

extension PendingRequestsViewController: PendingDonationTableViewCellDelegate {
    func pendingDonation(_ pendingDonationCell: PendingDonationTableViewCell, didSelectToCancelRequset: UIButton) {
        guard let indexPath = tableView.indexPath(for: pendingDonationCell) else {
            return debugPrint("no index path found for cell \(pendingDonationCell)")
        }
        
        let donation = pendingDonations[indexPath.row]
        
        let confirmCancelRequestAlert = UIAlertController(
            title: nil, message: "Are you sure you want to cancel this delivery reqesut for \(donation.title)?",
            preferredStyle: .actionSheet)
        
        let cancelRequestAction = UIAlertAction(title: "Cancel Request", style: .destructive) { _ in
            RequestService.cancelRequest(for: donation, completion: { (success) in
                if success {
                    self.pendingDonations.remove(at: indexPath.row)
                    self.tableView.deleteRows(at: [indexPath], with: .automatic)
                } else {
                    //TODO: error alert
                    let alert = UIAlertController(title: "Canceling a Reques", errorMessage: nil)
                    self.present(alert, animated: true)
                }
            })
        }
        confirmCancelRequestAlert.addAction(cancelRequestAction)
        
        let gobackAction = UIAlertAction(
            title: "Go Back", style: .cancel)
        confirmCancelRequestAlert.addAction(gobackAction)
        
        present(confirmCancelRequestAlert, animated: true)
    }
}
