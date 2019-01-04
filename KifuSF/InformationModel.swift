//
//  InformationModel.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 04/01/2019.
//  Copyright © 2019 Alexandru Turcanu. All rights reserved.
//

import UIKit

// MARK: - InformationModel
struct InformationModel {
    // MARK: - Variables
    private let information: String

    var cellTitle: String
    var errorAlertController: UIAlertController
    
    // MARK: - Initializers
    init(cellTitle: String, information: String, errorMessage: String? = nil) {
        self.cellTitle = cellTitle
        self.information = information
        self.errorAlertController = UIAlertController(errorMessage: errorMessage)
    }
}

// MARK: - SettingsItemProtocol
extension InformationModel: SettingsItemProtocol {
    var viewControllerToShow: UIViewController {
        let viewController = UIViewController()
        let textView = UITextView(
            font: UIFont.preferredFont(forTextStyle: .body),
            textColor: UIColor.Text.SubHeadline
        )

        viewController.view.addSubview(textView)
        viewController.view.directionalLayoutMargins = NSDirectionalEdgeInsetsMake(16, 16, 16, 16)

        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.autoPinEdgesToSuperviewMargins()

        textView.text = information
        textView.alwaysBounceVertical = true

        viewController.title = cellTitle
        viewController.view.backgroundColor = UIColor.Pallete.White

        return viewController
    }

    func didSelectItem(in viewController: UIViewController) {
        viewController.navigationController?.pushViewController(viewControllerToShow, animated: true)
    }
}
