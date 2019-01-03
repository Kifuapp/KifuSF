//
//  WebsiteModel.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 03/01/2019.
//  Copyright © 2019 Alexandru Turcanu. All rights reserved.
//

import UIKit
import SafariServices

// MARK: - WebsiteModel
struct WebsiteModel {
    // MARK: - Variables
    private let website: URL.Websites
    private let _cellTitle: String

    // MARK: - Initializers
    init(cellTitle: String, website: URL.Websites) {
        self._cellTitle = cellTitle
        self.website = website
    }
}

// MARK: - SettingsItemProtocol
extension WebsiteModel: SettingsItemProtocol {
    // MARK: - Variables
    var cellTitle: String {
        return _cellTitle
    }

    var viewController: UIViewController {
        guard let safariViewController = SFSafariViewController(website: website) else {
            return UIAlertController(errorMessage: "Something went wrong")
        }

        return safariViewController
    }

    // MARK: - Methods
    func didSelectItem(in viewController: UIViewController) {
        viewController.present(self.viewController, animated: true, completion: nil)
    }
}
