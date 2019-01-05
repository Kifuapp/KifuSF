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

        //TODO: self explanatory
        let newData = KFMUserInfo(
            profileImageURL: URL(string: "https://images.pexels.com/photos/356378/pexels-photo-356378.jpeg?auto=compress&cs=tinysrgb&h=350")!,
            name: "Alexandru Turcanu",
            username: "Pondorasti",
            userReputation: 100.0,
            userDonationsCount: 99,
            userDeliveriesCount: 99
        )
        donationCell.descriptorView.reloadData(for: newData)

        return donationCell
    }
}
