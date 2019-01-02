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
    private let settingsItemModels = [
        SettingsItemModel(name: "Donation Regulations"),
        SettingsItemModel(name: "Submit Feedback"),
        SettingsItemModel(name: "St. Anthony's Charity"),
        SettingsItemModel(name: "Terms of Service"),
        SettingsItemModel(name: "Privacy Policy"),
        SettingsItemModel(name: "Contact Us"),]

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
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return settingsItemModels.count
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default,
                                   reuseIdentifier: nil)

        settingsItemModels[indexPath.row].configureCell(cell)

        return cell
    }
}

// Mark: - UITableViewDelegate
extension SettingsViewController: UITableViewDelegate {

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


