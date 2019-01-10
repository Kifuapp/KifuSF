//
//  KFCFlagging.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 14/10/2018.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import UIKit

class FlaggingViewController: UIViewController {
    // MARK: - Variables
    private let flaggingInfoLabel = UILabel(font: UIFont.preferredFont(forTextStyle: .title2),
                                    textColor: UIColor.Text.SubHeadline)
    private let flaggingOptionsTableView = UITableView(forAutoLayout: ())
    
    var flaggableItems = [FlaggedContentType]()
    
    var userToReport: User? = nil
    var donationToReport: Donation? = nil

    /**
     <#Lorem ipsum dolor sit amet.#>

     TODO: present loading vc
     */

    // MARK: - Initializers
    convenience init(flaggableItems: [FlaggedContentType], user: User? = nil, donation: Donation? = nil) {
        self.init()
        
        self.flaggableItems = flaggableItems
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        configureDelegates()
        configureStyling()
        configureLayout()
    }

    // MARK: - Methods
    @objc private func dismissViewController() {
        dismiss(animated: true)
    }
}

// MARK: - UITableViewDataSource
extension FlaggingViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return flaggableItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: String(describing: flaggingOptionsTableView))
        
        cell.layoutMargins = UIEdgeInsets.zero
        cell.textLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        cell.textLabel?.textColor = UIColor.Text.Headline
        
        cell.textLabel?.text = flaggableItems[indexPath.row].getDescription()
        cell.tag = flaggableItems[indexPath.row].rawValue
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension FlaggingViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        // TODO: erick - use flagging service
        let alertController = UIAlertController(
            title: "Thanks for letting us know!",
            message: "We will shortly review your request and take action if needed.",
            preferredStyle: .alert
        )
        alertController.addCancelButton(title: "Dismiss") { [unowned self] (_) in
            self.dismiss(animated: true, completion: nil)
        }

        present(alertController, animated: true)
    }
}

// MARK: - UIConfigurable
extension FlaggingViewController: UIConfigurable {
    func configureDelegates() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: .kfCloseIcon,
            style: .plain,
            target: self,
            action: #selector(dismissViewController)
        )

        flaggingOptionsTableView.dataSource = self
        flaggingOptionsTableView.delegate = self
    }

    func configureStyling() {
        view.backgroundColor = UIColor.Pallete.White

        flaggingOptionsTableView.tableFooterView = UIView()
        flaggingOptionsTableView.addTableHeaderViewLine()
        flaggingOptionsTableView.layoutMargins = UIEdgeInsets.zero
        flaggingOptionsTableView.separatorInset = UIEdgeInsets.zero

        title = "Report an issue"
        flaggingInfoLabel.text = "Help us understand the problem. What is wrong with this?"
    }

    func configureLayout() {
        view.addSubview(flaggingInfoLabel)
        view.addSubview(flaggingOptionsTableView)

        configureFlaggingInfoLabelLayout()
        configureFlaggingOptionsTableViewLayout()
    }

    private func configureFlaggingInfoLabelLayout() {
        flaggingInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        flaggingInfoLabel.autoPinEdge(toSuperviewEdge: .top, withInset: KFPadding.StackView)
        flaggingInfoLabel.autoPinEdge(toSuperviewEdge: .leading, withInset: KFPadding.StackView)
        flaggingInfoLabel.autoPinEdge(toSuperviewEdge: .trailing, withInset: KFPadding.StackView)
    }

    private func configureFlaggingOptionsTableViewLayout() {
        flaggingOptionsTableView.autoPinEdge(.top, to: .bottom, of: flaggingInfoLabel, withOffset: KFPadding.StackView)
        flaggingOptionsTableView.autoPinEdge(toSuperviewEdge: .bottom)
        flaggingOptionsTableView.autoPinEdge(toSuperviewEdge: .leading)
        flaggingOptionsTableView.autoPinEdge(toSuperviewEdge: .trailing)
    }
}

