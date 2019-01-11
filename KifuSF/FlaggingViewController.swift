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
    
    var userToReport: User?
    var donationToReport: Donation?

    /**
     <#Lorem ipsum dolor sit amet.#>

     TODO: present loading vc
     */

    // MARK: - Initializers
    convenience init(
        flaggableItems: [FlaggedContentType],
        userToReport: User? = nil,
        donationToReport: Donation? = nil) {
        self.init()
        
        self.flaggableItems = flaggableItems
        self.userToReport = userToReport
        self.donationToReport = donationToReport
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
    
    private func createdReport(report: Report?) {
        guard report != nil else {
            UIAlertController(errorMessage: nil)
                .present(in: self)
            
            return
        }
        
        UIAlertController(
            title: "Thanks for letting us know!",
            message: "We will shortly review your request and take action if needed.",
            preferredStyle: .alert)
            .addCancelButton(title: "Dismiss") { [unowned self] (_) in
                self.dismissViewController()
            }
            .present(in: self)
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
        
        cell.textLabel?.text = flaggableItems[indexPath.row].description
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension FlaggingViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let selectedItem = flaggableItems[indexPath.row]
        
        //TODO: ask the user for a message on why they flagged it
        let message = "no comment"
        
        switch selectedItem.rawValue {
        case 0..<99: // flagged a donation
            guard let donation = self.donationToReport else {
                fatalError("provided a item from a donation without a donation")
            }
            
            ReportingService.createReport(
                for: donation,
                flaggingType: selectedItem,
                userMessage: message, completion: self.createdReport
            )
        case 100..<199: // flagged a user
            guard let user = self.userToReport else {
                fatalError("provided a item from a user without a user")
            }
            
            ReportingService.createReport(
                for: user,
                flaggingType: selectedItem,
                userMessage: message, completion: self.createdReport
            )
        default:
            fatalError("unsupported item")
        }
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

