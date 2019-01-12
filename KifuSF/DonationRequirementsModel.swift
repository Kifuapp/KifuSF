//
//  DonationRequirementsModel.swift
//  KifuSF
//
//  Created by Noah Woodward on 1/10/19.
//  Copyright © 2019 Alexandru Turcanu. All rights reserved.
//

import Foundation
import UIKit

struct DonationRequirementsModel {
    // MARK: - Variables
    var cellTitle: String
    var errorAlertController: UIAlertController
    
    // MARK: - Initializers
    init(cellTitle: String, errorMessage: String? = nil) {
        self.cellTitle = cellTitle
        self.errorAlertController = UIAlertController(errorMessage: errorMessage)
    }
}

// MARK: - SettingsItem
extension DonationRequirementsModel: SettingsItem {
    var viewControllerToShow: UIViewController {
        let donationRequirementsVC = DonationRequirementsViewController()
        return donationRequirementsVC
    }
    
    func didSelectItem(in viewController: UIViewController) {
        viewController.navigationController?.pushViewController(viewControllerToShow, animated: true)
    }
}


