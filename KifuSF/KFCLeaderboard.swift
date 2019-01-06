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
        title = "Leaderboard"
        view.backgroundColor = UIColor.Pallete.Gray

//        let _ = tableViewWithRoundedCellsConstraints.map() { $0.autoRemove() }
//        tableViewWithRoundedCells.autoPinEdge(toSuperviewEdge: .top)
//        tableViewWithRoundedCells.autoPinEdge(toSuperviewEdge: .leading)
//        tableViewWithRoundedCells.autoPinEdge(toSuperviewEdge: .trailing)

        tableViewWithRoundedCells.dataSource = self
        tableViewWithRoundedCells.isScrollEnabled = false
        tableViewWithRoundedCells.allowsSelection = false
        tableViewWithRoundedCells.register(KFVRoundedCell<KFVUserInfo>.self, forCellReuseIdentifier: KFVRoundedCell<KFVUserInfo>.identifier)
    }
}

extension KFCLeaderboard: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let donationCell = tableView.dequeueReusableCell(withIdentifier: KFVRoundedCell<KFVUserInfo>.identifier) as? KFVRoundedCell<KFVUserInfo> else {
            fatalError(KFErrorMessage.unknownCell)
        }
        
        let user = User.current
        let newData = KFMUserInfo(
            profileImageURL: URL(string: user.imageURL)!,
            name: "", //TODO: user's fullname
            username: user.username,
            userReputation: user.reputation,
            userDonationsCount: user.numberOfDonations,
            userDeliveriesCount: user.numberOfDeliveries
        )
        donationCell.descriptorView.reloadData(for: newData)

        return donationCell
    }
}
