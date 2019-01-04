//
//  SettingsViewController.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 02/01/2019.
//  Copyright © 2019 Alexandru Turcanu. All rights reserved.
//

import UIKit
import MessageUI

// MARK: - MailComposerModel
struct MailComposerModel {
    // MARK: - Variables
    private let errorAlert = UIAlertController(errorMessage: "Something went wrong")
    private var composeViewController: MFMailComposeViewController {
        let viewController = MFMailComposeViewController()

        viewController.setToRecipients(recipients)
        viewController.setSubject(subject)
        viewController.setMessageBody(body, isHTML: false)

        return viewController
    }

    private let recipients: [String]
    private let subject: String
    private let body: String

    var cellTitle: String

    // MARK: - Initializers
    init(cellTitle: String, recipients: [String], subject: String, body: String) {
        self.cellTitle = cellTitle

        self.recipients = recipients
        self.subject = subject
        self.body = body
    }

}

// MARK: - SettingsItemProtocol
extension MailComposerModel: SettingsItemProtocol {
    // MARK: - Variables
    var viewControllerToShow: UIViewController {
        if MFMailComposeViewController.canSendMail() {
            return composeViewController
        } else {
            return errorAlert
        }
    }
}

class SettingsViewController: UIViewController {
    // MARK: - Variables
    private let settingsItems: [SettingsItemProtocol] = [
        WebsiteModel(cellTitle: "St. Anthony Charity",
                     website: .stAnthony),
        MailComposerModel(cellTitle: "Submit Feedback",
                          recipients: ["alexandru_turcanu@ymailc.com"],
                          subject: "Feedback",
                          body: "Don't be shy 😉")

    ]
//    SettingsItemModel(name: "Donation Regulations"),
//    SettingsItemModel(name: "Submit Feedback"),
//    SettingsItemModel(name: "St. Anthony's Charity", websiteToShow: .stAnthony),
//    SettingsItemModel(name: "Terms of Service"),
//    SettingsItemModel(name: "Privacy Policy"),
//    SettingsItemModel(name: "Contact Us"),

    private(set) var tableView = UITableView(forAutoLayout: ())

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        configureDelegates()
        configureStyling()
        configureLayout()
    }
}

// MARK: - UITableViewDelegate
extension SettingsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default,
                                   reuseIdentifier: nil)

        settingsItems[indexPath.row].configureCell(cell)

        return cell
    }
}

// MARK: - UITableViewDelegate
extension SettingsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        settingsItems[indexPath.row].didSelectItem(in: self)
    }
}

// MARK: - UIConfigurable
extension SettingsViewController: UIConfigurable {
    func configureData() {
        title = "Settings"
    }
    
    func configureDelegates() {
        tableView.dataSource = self
        tableView.delegate = self
    }

    func configureStyling() {
        view.backgroundColor = UIColor.Pallete.White
    }

    func configureLayout() {
        view.addSubview(tableView)

        tableView.autoPinEdgesToSuperviewEdges()
    }
}
