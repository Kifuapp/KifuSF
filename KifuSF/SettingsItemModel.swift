//
//  SettingsItemModel.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 02/01/2019.
//  Copyright © 2019 Alexandru Turcanu. All rights reserved.
//

import UIKit
import SafariServices

struct SettingsItemModel {
    let name: String
    let settingsItem: SettingsItemProtocol

    init(name: String,
         settingsItem: SettingsItemProtocol) {

        self.name = name
        self.settingsItem = settingsItem
    }

    func configureCell(_ cell: UITableViewCell) {
        cell.textLabel?.text = name
        cell.textLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        cell.textLabel?.textColor = UIColor.Text.Headline
        cell.accessoryType = .disclosureIndicator
    }

    //ignore this function
    func handleTap(in viewController: UIViewController) {
//        if let website = websiteToShow,

//        let url = URL(website: .stAnthony)!
////            let url = URL(website: .stAnthony) {
//
//            let safariViewController = SFSafariViewController(website: URL.Websites.stAnthony)
//            viewController.present(safariViewController, animated: true, completion: nil)
//
//        }

//        print(safariViewController == viewControllerToShow)

//        if let viewControllerToShow = viewControllerToShow as? SFSafariViewController {
//            viewController.present(viewControllerToShow!, animated: true, completion: nil)
//        }
    }
}
