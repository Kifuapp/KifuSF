//
//  SettingsViewController.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 02/01/2019.
//  Copyright © 2019 Alexandru Turcanu. All rights reserved.
//

import UIKit
import SafariServices

class SettingsViewController: UIViewController {
    // MARK: - Variables
    private let settingsItems: [SettingsItemProtocol] = [WebsiteModel(website: .stAnthony)]
//    SettingsItemModel(name: "Donation Regulations"),
//    SettingsItemModel(name: "Submit Feedback"),
//    SettingsItemModel(name: "St. Anthony's Charity", websiteToShow: .stAnthony),
//    SettingsItemModel(name: "Terms of Service"),
//    SettingsItemModel(name: "Privacy Policy"),
//    SettingsItemModel(name: "Contact Us"),

    private let tableView = UITableView(forAutoLayout: ())

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

        //TODO: reimplement configureCell
//        settingsItems[indexPath.row].configureCell(cell)
        cell.textLabel?.text = "poof"

        return cell
    }
}

// MARK: - UITableViewDelegate
extension SettingsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true) //maybe move this in viewWillAppear/didAppear
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

// MARK: - SettingsItemProtocol
protocol SettingsItemProtocol {
    var cellTitle: String { get }
    var viewController: UIViewController { get }

    func didSelectItem(in viewController: UIViewController)
}

// MARK: - WebsiteModel
struct WebsiteModel {
    // MARK: - Variables
    private let website: URL.Websites

    // MARK: - Initializers
    init(website: URL.Websites) {
        self.website = website
    }
}

// MARK: - SettingsItemProtocol
extension WebsiteModel: SettingsItemProtocol {
    // MARK: - Variables
    var cellTitle: String {
        return "Website"
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
