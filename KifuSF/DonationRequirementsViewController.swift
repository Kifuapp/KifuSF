//
//  DonationRequirementsViewController.swift
//  KifuSF
//
//  Created by Noah Woodward on 1/9/19.
//  Copyright © 2019 Alexandru Turcanu. All rights reserved.
//

import UIKit

class DonationRequirementsViewController: UIViewController {
    // MARK: - Variables
    private let donationRequirementsTextView = UITextView(
        font: UIFont.preferredFont(forTextStyle: .body),
        textColor: UIColor.Text.Headline
    )

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        configureData()
        configureLayout()
    }
}

// MARK: - UIConfigurable
extension DonationRequirementsViewController: UIConfigurable {
    func configureData() {
        title = "Requirements"

        DonationRequirementsService.getRequirementsText { (requirementsText) in
            if let requirementsText = requirementsText {
                self.donationRequirementsTextView.text = requirementsText
            } else{
                self.donationRequirementsTextView.text = "Unable to Retrieve Requirements Text"
            }
        }
    }

    func configureLayout() {
        view.addSubview(donationRequirementsTextView)
        view.directionalLayoutMargins = NSDirectionalEdgeInsetsMake(16, 16, 16, 16)

        donationRequirementsTextView.translatesAutoresizingMaskIntoConstraints = false
        donationRequirementsTextView.autoPinEdgesToSuperviewMargins()

        donationRequirementsTextView.alwaysBounceVertical = true

        view.backgroundColor = UIColor.Pallete.White
    }
}
