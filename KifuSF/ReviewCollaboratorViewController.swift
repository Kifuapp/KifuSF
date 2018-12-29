//
//  ReviewCollaboratorViewController.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 29/12/2018.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import UIKit
import Cosmos

class ReviewCollaboratorViewController: UIViewController {

    private let collaboratorInfoDescriptorView = ReviewCollaboratorDescriptorView(forAutoLayout: ())
    private let sumbitAnimatedButton = UIAnimatedButton(backgroundColor: .kfPrimary,
                                                        andTitle: "Submit")

    override func viewDidLoad() {
        super.viewDidLoad()

        configureData()
        configureStyling()
        configureLayout()

    }

    @objc private func dismissViewController() {
        dismiss(animated: true)
    }
}

//MARK: - UIConfigurable
extension ReviewCollaboratorViewController: UIConfigurable {
    func configureDelegates() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .stop,
            target: self,
            action: #selector(dismissViewController)
        )
    }

    func configureData() {
        title = "Review"

        collaboratorInfoDescriptorView.reloadData(for: KFMCollaboratorInfo(profileImageURL: URL(string: "https://images.pexels.com/photos/356378/pexels-photo-356378.jpeg?auto=compress&cs=tinysrgb&h=350")!, name: "Alex", username: "Pondorasti", userReputation: 12, userDonationsCount: 12, userDeliveriesCount: 12))
    }

    func configureStyling() {
        view.backgroundColor = .kfGray
    }

    func configureLayout() {
        view.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16)

        view.addSubview(collaboratorInfoDescriptorView)
        view.addSubview(sumbitAnimatedButton)

        collaboratorInfoDescriptorView.autoPinEdge(toSuperviewMargin: .leading)
        collaboratorInfoDescriptorView.autoPinEdge(toSuperviewMargin: .trailing)
        collaboratorInfoDescriptorView.autoPinEdge(toSuperviewMargin: .top)


        configureSumbitAnimatedButtonConstraints()
    }

    private func configureSumbitAnimatedButtonConstraints() {
        sumbitAnimatedButton.translatesAutoresizingMaskIntoConstraints = false

        sumbitAnimatedButton.autoPinEdge(toSuperviewMargin: .leading)
        sumbitAnimatedButton.autoPinEdge(toSuperviewMargin: .trailing)
        sumbitAnimatedButton.autoPinEdge(toSuperviewMargin: .bottom)
    }
}
