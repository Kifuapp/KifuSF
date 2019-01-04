//
//  SettingsItemProtocol.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 03/01/2019.
//  Copyright © 2019 Alexandru Turcanu. All rights reserved.
//

import UIKit

// MARK: - SettingsItemProtocol
protocol SettingsItemProtocol {
    var cellTitle: String { get }
    var viewControllerToShow: UIViewController { get }
    var errorAlertController: UIAlertController { get }

    func configureCell(_ cell: UITableViewCell)
    func didSelectItem(in viewController: UIViewController)
}

// MARK: - Extension
extension SettingsItemProtocol {
    func configureCell(_ cell: UITableViewCell) {
        cell.textLabel?.text = cellTitle
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.textColor = UIColor.Text.Headline
        cell.textLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
    }

    func didSelectItem(in viewController: UIViewController) {
        viewController.present(viewControllerToShow, animated: true)
    }
}
