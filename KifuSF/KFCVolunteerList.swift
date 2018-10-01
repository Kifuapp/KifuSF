//
//  KFCVolunteerList.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 16/09/2018.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import UIKit

class KFCVolunteerList: KFCTableViewWithRoundedCells {
    
    //TODO: remove this
    var numberOfRows = 20
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Volunteers"
        
        tableViewWithRoundedCells.register(KFVRoundedCell<KFVVolunteerInfo>.self, forCellReuseIdentifier: KFVRoundedCell<KFVVolunteerInfo>.identifier)
        
        tableViewWithRoundedCells.dataSource = self
        tableViewWithRoundedCells.allowsSelection = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableViewWithRoundedCells.reloadData()
    }
}

extension KFCVolunteerList: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfRows
        //TODO: return actual amount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let volunteerInfoCell = tableView.dequeueReusableCell(withIdentifier: KFVRoundedCell<KFVVolunteerInfo>.identifier, for: indexPath) as? KFVRoundedCell<KFVVolunteerInfo> else {
            fatalError(KFErrorMessage.unknownCell)
        }
        
        //TODO: self explanatory
        let newData = KFMVolunteerInfo(imageURL: URL(string: "https://images.pexels.com/photos/356378/pexels-photo-356378.jpeg?auto=compress&cs=tinysrgb&h=350")!, username: "Pondorasti", userReputation: 100, userDonationsCount: 99, userDeliveriesCount: 99)
        volunteerInfoCell.descriptorView.reloadData(for: newData)
        volunteerInfoCell.descriptorView.delegate = self
        
        volunteerInfoCell.descriptorView.indexPath = indexPath
        
        return volunteerInfoCell
    }
}

extension KFCVolunteerList: KFPVolunteerInfoCellDelegate {
    func didPressButton(_ sender: KFVRoundedCell<KFVVolunteerInfo>) {
        //TODO: hook up with firebase
        let indexPath = tableViewWithRoundedCells.indexPath(for: sender)
        
        print(indexPath)
        numberOfRows -= 1
        tableViewWithRoundedCells.deleteRows(at: [indexPath!], with: .fade)
    }
}
