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
        
        tableView.register(KFVRoundedCell<KFVVolunteerInfo>.self, forCellReuseIdentifier: KFVRoundedCell<KFVVolunteerInfo>.identifier)
        
        tableView.dataSource = self
        tableView.allowsSelection = false
    }
}

extension KFCVolunteerList: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
        //TODO: return actual amount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let volunteerInfoCell = tableView.dequeueReusableCell(withIdentifier: KFVRoundedCell<KFVVolunteerInfo>.identifier, for: indexPath) as? KFVRoundedCell<KFVVolunteerInfo> else {
            fatalError(KFErrorMessage.unknownCell)
        }
        
        volunteerInfoCell.descriptorView.delegate = self
        
        return volunteerInfoCell
    }
}

extension KFCVolunteerList: KFPVolunteerInfoCellDelegate {
    func didPressButton() {
        print("cancel button pressed")
        
        //TODO: hook up with firebase
    }
}
