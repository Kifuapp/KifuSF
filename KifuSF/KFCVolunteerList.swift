//
//  KFCVolunteerList.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 16/09/2018.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import UIKit

class KFCVolunteerList: KFCTableViewWithRoundedCells {
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
}

extension KFCVolunteerList: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
        //TODO: erick-return actual amount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let volunteerInfoCell = tableView.dequeueReusableCell(
            withIdentifier: KFVRoundedCell<KFVVolunteerInfo>.identifier,
            for: indexPath) as? KFVRoundedCell<KFVVolunteerInfo> else {
            fatalError(KFErrorMessage.unknownCell)
        }
        
        //TODO: erick-self explanatory
        fatalError("\(#function) not implemented")
//        let newData = KFMVolunteerInfo(imageURL: URL(
//        string: "https://images.pexels.com/photos/356378/pexels-photo-356378.jpeg?auto=compress&cs=tinysrgb&h=350")!,
//        username: "Pondorasti", userReputation: 100, userDonationsCount: 99, userDeliveriesCount: 99)
//        volunteerInfoCell.descriptorView.reloadData(for: newData)
//        volunteerInfoCell.descriptorView.delegate = self
//
//        return volunteerInfoCell
    }
}

extension KFCVolunteerList: KFPVolunteerInfoCellDelegate {
    func didPressButton() {
        print("cancel button pressed")
        
        //TODO: erick-hook up with firebase
    }
}
