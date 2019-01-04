//
//  SettingsViewController.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 02/01/2019.
//  Copyright © 2019 Alexandru Turcanu. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    // MARK: - Variables
    private let settingsItems: [SettingsItem] = [
        InformationModel(cellTitle: "Donation Regulations",
                         information: KifuLocalization.regulations),
        WebsiteModel(cellTitle: "St. Anthony Charity",
                     website: .stAnthony),
        MailComposerModel(cellTitle: "Submit Feedback",
                          recipients: [KifuLocalization.feedbackMail],
                          subject: "Feedback",
                          body: "Don't be shy 😉"),
        MailComposerModel(cellTitle: "Contact Us",
                          recipients: [KifuLocalization.contactUsMail],
                          subject: "Contact Us",
                          body: "Don't be shy 😉"),
        WebsiteModel(cellTitle: "Terms of Service",
                     website: .termsOfService),
        WebsiteModel(cellTitle: "Privacy Policy",
                     website: .privacyPolicy)
    ]

    private let tableView = UITableView(forAutoLayout: ())

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        configureData()
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
        let cell = UITableViewCell(
            style: .default,
            reuseIdentifier: nil
        )

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
