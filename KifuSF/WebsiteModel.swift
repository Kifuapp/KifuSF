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
    
    var cellTitle: String
    var errorAlertController: UIAlertController

    // MARK: - Initializers
    init(cellTitle: String, website: URL.Websites, errorMessage: String? = nil) {
        self.cellTitle = cellTitle
        self.website = website
        self.errorAlertController = UIAlertController(errorMessage: errorMessage)
    }
}

// MARK: - SettingsItemProtocol
extension WebsiteModel: SettingsItemProtocol {
    // MARK: - Variables
    var viewControllerToShow: UIViewController {
        guard let safariViewController = SFSafariViewController(website: website) else {
            return errorAlertController
        }

        return safariViewController
    }
}
