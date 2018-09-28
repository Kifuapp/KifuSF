//
//  KFCVolunteerList.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 16/09/2018.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import UIKit

class KFCVolunteerList: KFCTableViewWithRoundedCells {
    
    // MARK: - VARS
    
    var volunteers: [User]!
    
    // MARK: - RETURN VALUES
    
    // MARK: - METHODS
    
    // MARK: - IBACTIONS
    
    // MARK: - LIFE CYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Volunteers"
        
        tableView.register(
            KFVRoundedCell<KFVVolunteerInfo>.self,
            forCellReuseIdentifier: KFVRoundedCell<KFVVolunteerInfo>.identifier
        )
        
        tableView.dataSource = self
        tableView.allowsSelection = false
    }
}

extension KFCVolunteerList: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return volunteers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let volunteerInfoCell = tableView.dequeueReusableCell(
            withIdentifier: KFVRoundedCell<KFVVolunteerInfo>.identifier,
            for: indexPath) as? KFVRoundedCell<KFVVolunteerInfo> else {
            fatalError(KFErrorMessage.unknownCell)
        }
        
        let volunteer = self.volunteers[indexPath.row]
        
        //TODO: alex-fetch reputation values from User Class
        let volunteerRep: Double = 0
        let volunteerDonationCount: Int = 0
        let volunteerDeliveryCount: Int = 0
        let data = KFMVolunteerInfo(
            imageURL: URL(string: volunteer.imageURL)!,
            username: volunteer.username,
            userReputation: volunteerRep,
            userDonationsCount: volunteerDonationCount,
            userDeliveriesCount: volunteerDeliveryCount
        )
        
        volunteerInfoCell.descriptorView.reloadData(for: data)
        
        return volunteerInfoCell
    }
}

extension KFCVolunteerList: KFPVolunteerInfoCellDelegate {
    func didPressButton() {
        print("cancel button pressed")
        
        //TODO: erick-hook up with firebase
    }
}
