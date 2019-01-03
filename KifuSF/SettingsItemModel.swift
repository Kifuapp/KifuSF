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
    let websiteToShow: URL.Websites?
    let selector: Selector?

    init(name: String,
         websiteToShow: URL.Websites? = nil,
         selector: Selector? = nil) {
        
        self.name = name
        self.websiteToShow = websiteToShow
        self.selector = selector
    }

    func configureCell(_ cell: UITableViewCell) {
        cell.textLabel?.text = name
        cell.textLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        cell.textLabel?.textColor = UIColor.Text.Headline
        cell.accessoryType = .disclosureIndicator
    }

    func handleTap(in viewController: UIViewController) {
        if let website = websiteToShow,
            let url = URL(website: website) {

            let safariViewController = SFSafariViewController(url: url)
            viewController.present(safariViewController, animated: true, completion: nil)
        }
    }
}
