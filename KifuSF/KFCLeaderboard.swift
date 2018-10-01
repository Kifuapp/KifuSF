//
//  KFCLeaderboard.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 01/10/2018.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import UIKit

class KFCLeaderboard: KFCTableViewWithRoundedCells {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

extension KFCLeaderboard: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let donationCell = tableView.dequeueReusableCell(withIdentifier: KFVRoundedCell<KFVDonationInfo>.identifier) as? KFVRoundedCell<KFVDonationInfo> else {
            fatalError(KFErrorMessage.unknownCell)
        }
        
        //TODO: self explanatory
        let newData = KFMDonationInfo(imageURL: URL(string: "https://images.pexels.com/photos/356378/pexels-photo-356378.jpeg?auto=compress&cs=tinysrgb&h=350")!, title: "Doggo", distance: 12.3, description: "woof woof")
        donationCell.descriptorView.reloadData(for: newData)
        
        return donationCell
    }
}
