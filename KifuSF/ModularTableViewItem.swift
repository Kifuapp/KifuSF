//
//  ModularTableViewItem.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 04/01/2019.
//  Copyright © 2019 Alexandru Turcanu. All rights reserved.
//

import UIKit

protocol ModularTableViewItem {
    // MARK: - Variables
    var type: ModularTableViewController.CellTypes { get }
    var sectionTitle: String { get }
    var rowCount: Int { get }
}

// MARK: - Extension
extension ModularTableViewItem {
    var sectionTitle: String {
        return "Not aplicable"
    }

    var rowCount: Int {
        return 1
    }
}
