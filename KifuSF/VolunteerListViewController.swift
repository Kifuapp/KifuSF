//
//  VolunteerListViewController.swift
//  KifuSF
//
//  Created by Shutaro Aoyama on 2018/07/28.
//  Copyright © 2018年 Alexandru Turcanu. All rights reserved.
//

import UIKit

class VolunteerListViewController: UIViewController {
    
    var donation: OpenDonation!
    var volunteers = [User]() {
        didSet {
            volunteerTable.reloadData()
        }
    }
    
    // MARK: - RETURN VALUES
    
    // MARK: - VOID METHODS
    
    // MARK: - IBACTIONS
    
    @IBOutlet weak var volunteerTable: UITableView!
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true)
    }
    
    // MARK: - LIFE CYCLE
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        RequestService.retrieveVolunteers(for: donation) { (users) in
            self.volunteers = users
            
            //TODO: stop loading
        }
        
        //TODO: Shu-loading indicator
    }

}

extension VolunteerListViewController: UITableViewDelegate {
    
}

extension VolunteerListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return volunteers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let volunteerCell = volunteerTable.dequeueReusableCell(withIdentifier: "volunteerCell") as! VolunteerCell
        volunteerCell.delegate = self
        
        let volunteer = volunteers[indexPath.row]
        
        volunteerCell.userName.text = "Contribution Points: \(121)"
        volunteerCell.name.text = volunteer.username
        volunteerCell.userImage.kf.setImage(with: URL(string: volunteer.imageURL)!)
        
        
        return volunteerCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 117
    }
}

extension VolunteerListViewController: VolunteerCellDelegate {
    func confirmButtonTapped(cell: VolunteerCell) {
        guard let indexPath = volunteerTable.indexPath(for: cell) else {
            fatalError("no cell found for selected cell")
        }
        
        let selectedVolunteer = volunteers[indexPath.row]
        
        DonationService.accept(volunteer: selectedVolunteer, for: donation) { (success) in
            if success {
                self.presentingViewController?.dismiss(animated: true)
            } else {
                //TODO: prompt error message
            }
        }
    }
}


