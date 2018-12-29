//
//  ReviewCollaboratorViewController.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 29/12/2018.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import UIKit
import Cosmos

class ReviewCollaboratorViewController: UIScrollableViewController {
    //MARK: - Variables
    private let reviewCollaboratorInfoDescriptorView = ReviewCollaboratorDescriptorView(forAutoLayout: ())
    private let sumbitAnimatedButton = UIAnimatedButton(backgroundColor: .kfPrimary,
                                                        andTitle: "Submit")

    private var rating: Double? = nil
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        configureDelegates()
        configureData()
        configureStyling()
        configureLayout()
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        contentScrollView.updateBottomPadding(sumbitAnimatedButton.frame.height + 24)
    }

    //MARK: - Methods
    @objc private func dismissViewController() {
        dismiss(animated: true)
    }

    @objc private func submitAnimatedButtonTapped() {
        //make sure the user has made a review
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

        sumbitAnimatedButton.addTarget(self, action: #selector(submitAnimatedButtonTapped), for: .touchUpInside)

        reviewCollaboratorInfoDescriptorView.cosmosView.didFinishTouchingCosmos = { [unowned self] rating in
            self.rating = rating
        }
    }

    func configureData() {
        title = "Review"
        reviewCollaboratorInfoDescriptorView.motivationalLabel.text =
            ReviewCollaboratorDescriptorView.motivationalMessages.first

        reviewCollaboratorInfoDescriptorView.reloadData(for: KFMCollaboratorInfo(profileImageURL: URL(string: "https://images.pexels.com/photos/356378/pexels-photo-356378.jpeg?auto=compress&cs=tinysrgb&h=350")!, name: "Alex", username: "Pondorasti", userReputation: 12, userDonationsCount: 12, userDeliveriesCount: 12))
    }

    func configureStyling() {
        view.backgroundColor = .kfGray
        contentScrollView.alwaysBounceVertical = false
    }

    func configureLayout() {
        outerStackView.addArrangedSubview(reviewCollaboratorInfoDescriptorView)
        view.addSubview(sumbitAnimatedButton)

        reviewCollaboratorInfoDescriptorView.autoPinEdge(toSuperviewMargin: .leading)
        reviewCollaboratorInfoDescriptorView.autoPinEdge(toSuperviewMargin: .trailing)
        reviewCollaboratorInfoDescriptorView.autoPinEdge(toSuperviewMargin: .top)


        configureSumbitAnimatedButtonConstraints()
    }

    private func configureSumbitAnimatedButtonConstraints() {
        sumbitAnimatedButton.translatesAutoresizingMaskIntoConstraints = false

        sumbitAnimatedButton.autoPinEdge(toSuperviewMargin: .leading)
        sumbitAnimatedButton.autoPinEdge(toSuperviewMargin: .trailing)
        sumbitAnimatedButton.autoPinEdge(toSuperviewMargin: .bottom)
    }
}
