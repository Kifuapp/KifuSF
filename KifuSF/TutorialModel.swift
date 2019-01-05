//
//  TutorialModel.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 05/01/2019.
//  Copyright © 2019 Alexandru Turcanu. All rights reserved.
//

import UIKit

struct TutorialModel {
    var cellTitle: String
    var errorAlertController: UIAlertController

    init(cellTitle: String, errorMessage: String? = nil) {
        self.cellTitle = cellTitle
        self.errorAlertController = UIAlertController(errorMessage: errorMessage)
    }
}

extension TutorialModel: SettingsItem {
    var viewControllerToShow: UIViewController {
        let tutorialViewController = TutorialViewController()

        return tutorialViewController
    }
}


