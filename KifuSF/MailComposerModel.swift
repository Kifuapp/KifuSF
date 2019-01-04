//
//  MailComposerModel.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 04/01/2019.
//  Copyright © 2019 Alexandru Turcanu. All rights reserved.
//

import UIKit
import MessageUI

//this class requires subclassing NSObject in order to conform to MFMailComposeViewControllerDelegate

// MARK: - MailComposerModel
class MailComposerModel: NSObject {
    // MARK: - Variables
    private var composeViewController: MFMailComposeViewController {
        let viewController = MFMailComposeViewController()

        viewController.setToRecipients(recipients)
        viewController.setSubject(subject)
        viewController.setMessageBody(body, isHTML: false)
        viewController.mailComposeDelegate = self

        return viewController
    }

    private let recipients: [String]
    private let subject: String
    private let body: String

    var cellTitle: String
    var errorAlertController: UIAlertController

    // MARK: - Initializers
    init(cellTitle: String,
         recipients: [String],
         subject: String,
         body: String,
         errorMessage: String? = nil) {

        self.recipients = recipients
        self.subject = subject
        self.body = body

        self.cellTitle = cellTitle
        self.errorAlertController = UIAlertController(errorMessage: errorMessage)
    }
}

// MARK: - MFMailComposeViewControllerDelegate
extension MailComposerModel: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController,
                               didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
}

// MARK: - SettingsItemProtocol
extension MailComposerModel: SettingsItem {
    // MARK: - Variables
    var viewControllerToShow: UIViewController {
        if MFMailComposeViewController.canSendMail() {
            return composeViewController
        } else {
            return errorAlertController
        }
    }
}
