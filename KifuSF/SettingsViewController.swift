//
//  SettingsViewController.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 02/01/2019.
//  Copyright © 2019 Alexandru Turcanu. All rights reserved.
//

import UIKit
import SafariServices

extension SFSafariViewController {
    convenience init?(website: URL.Websites) {
        guard let url = URL(website: website) else {
            return nil
        }

        self.init(url: url)
    }
}

class SettingsViewController: UIViewController {
    // MARK: - Variables
    private let settingsItemModels = [
        SettingsItemModel(name: "Test", viewControllerToShow: SFSafariViewController(website: .stAnthony)),
        SettingsItemModel(name: "Test", viewControllerToShow: KFCFlagging(flaggableItems: [FlaggedContentType.flaggedCommunication]))
        ]

//    SettingsItemModel(name: "Donation Regulations"),
//    SettingsItemModel(name: "Submit Feedback"),
//    SettingsItemModel(name: "St. Anthony's Charity", websiteToShow: .stAnthony),
//    SettingsItemModel(name: "Terms of Service"),
//    SettingsItemModel(name: "Privacy Policy"),
//    SettingsItemModel(name: "Contact Us"),

    private let tableView = UITableView(forAutoLayout: ())


    override func viewDidLoad() {
        super.viewDidLoad()

        configureDelegates()
        configureStyling()
        configureLayout()
    }
}

// Mark: - UITableViewDelegate
extension SettingsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsItemModels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default,
                                   reuseIdentifier: nil)

        settingsItemModels[indexPath.row].configureCell(cell)

        return cell
    }
}

// Mark: - UITableViewDelegate
extension SettingsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        settingsItemModels[indexPath.row].handleTap(in: self)
//        tableView.deselectRow(at: indexPath, animated: true)

        present(SFSafariViewController(website: .stAnthony)!, animated: true, completion: nil) //this works
        present(settingsItemModels[indexPath.row].viewControllerToShow!, animated: true, completion: nil) //this doesn't work :(
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


