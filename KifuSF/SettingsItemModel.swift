//
//  SettingsItemModel.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 02/01/2019.
//  Copyright © 2019 Alexandru Turcanu. All rights reserved.
//

import UIKit

struct SettingsItemModel {
    let name: String
    let viewControllerToPush: UIViewController?
    let selector: Selector?

    init(name: String,
         viewControllerToPush: UIViewController? = nil,
         selector: Selector? = nil) {
        
        self.name = name
        self.viewControllerToPush = viewControllerToPush
        self.selector = selector
    }

    func configureCell(_ cell: UITableViewCell) {
        cell.textLabel?.text = name

        if let _ = viewControllerToPush {
            cell.accessoryType = .disclosureIndicator
        } else {
            cell.accessoryType = .none
        }
    }
}
