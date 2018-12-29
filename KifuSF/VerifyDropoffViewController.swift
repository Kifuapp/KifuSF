//
//  VerifyDropoffViewController.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 28/12/2018.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import UIKit

class VerifyDropoffViewController: UIViewController {
    //MARK: - Variables
    private let titleLabel = UILabel(font: UIFont.preferredFont(forTextStyle: .headline),
                                       textColor: .kfTitle)
    private let dropoffImageView = UIImageView(forAutoLayout: ())

    private let bottomStackView = UIStackView(axis: .vertical, alignment: .fill, spacing: 16, distribution: .fill)
    private let confirmationAnimatedButton = UIAnimatedButton(backgroundColor: .kfPrimary,
                                                              andTitle: "Confirm dropoff")

    private let labelsStackView = UIStackView(axis: .horizontal, alignment: .fill, spacing: 4, distribution: .fill)

    private let flagDescriptionLabel = UILabel(font: UIFont.preferredFont(forTextStyle: .footnote), textColor: .kfBody)
    private let flagLabel = UILabel(font: UIFont.preferredFont(forTextStyle: .footnote), textColor: .kfDestructive)

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        configureData()
        configureDelegates()
        configureStyling()
        configureLayout()
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        let isAccessibilityCategory = traitCollection.preferredContentSizeCategory.isAccessibilityCategory
        
        if isAccessibilityCategory {
            labelsStackView.axis = .vertical

            flagDescriptionLabel.numberOfLines = 0
            flagLabel.numberOfLines = 0
        } else {
            labelsStackView.axis = .horizontal

            flagDescriptionLabel.numberOfLines = 1
            flagLabel.numberOfLines = 1
        }
    }

    //MARK: - Methods
    @objc private func dismissViewController() {
        dismiss(animated: true)
    }

    @objc private func confirmationAnimatedButtonTapped() {
        //TODO: erick - do whatever is needed
        print("confirm")
    }

    @objc private func reportButtonTapped() {
        //TODO: erick - update the flagging initializers to also pass the donation object
        let flaggingViewController = KFCFlagging(flaggableItems: [.flaggedVerificationImage])
        navigationController?.pushViewController(flaggingViewController, animated: true)
    }
}

//MARK: - UIConfigurable
extension VerifyDropoffViewController: UIConfigurable {
    func configureDelegates() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .stop,
            target: self,
            action: #selector(dismissViewController)
        )

        confirmationAnimatedButton.addTarget(self, action: #selector(confirmationAnimatedButtonTapped), for: .touchUpInside)
        labelsStackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(reportButtonTapped)))
    }

    func configureData() {
        title = "Security Step"
        titleLabel.text = "Validate Volunteer's image"
        dropoffImageView.kf.setImage(with: URL(string: "https://images.pexels.com/photos/356378/pexels-photo-356378.jpeg?auto=compress&cs=tinysrgb&h=350")!)

        flagDescriptionLabel.text = "Image not looking right?"
        flagLabel.text = "Tap here to report."
    }

    func configureStyling() {
        view.backgroundColor = .kfWhite
        titleLabel.textAlignment = .center

        dropoffImageView.makeItKifuStyle()

        //set default styling when accessibility is not present
        flagDescriptionLabel.numberOfLines = 1
        flagLabel.numberOfLines = 1
    }

    func configureLayout() {
        view.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16)

        view.addSubview(titleLabel)
        view.addSubview(dropoffImageView)
        view.addSubview(bottomStackView)

        labelsStackView.addArrangedSubview(flagDescriptionLabel)
        labelsStackView.addArrangedSubview(flagLabel)

        bottomStackView.addArrangedSubview(confirmationAnimatedButton)
        bottomStackView.addArrangedSubview(labelsStackView)

        flagLabel.setContentHuggingPriority(.init(249), for: .horizontal)

        configureTitleLabelConstraints()
        configureDropoffImageViewConstraints()
        configureBottomStackViewConstraints()
    }

    private func configureTitleLabelConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        titleLabel.autoPinEdge(toSuperviewMargin: .top)
        titleLabel.autoPinEdge(toSuperviewMargin: .leading)
        titleLabel.autoPinEdge(toSuperviewMargin: .trailing)
        titleLabel.autoAlignAxis(toSuperviewAxis: .vertical)
    }

    private func configureDropoffImageViewConstraints() {
        dropoffImageView.autoPinEdge(.top, to: .bottom, of: titleLabel, withOffset: 64)
        dropoffImageView.autoPinEdge(toSuperviewMargin: .leading, withInset: 32)
        dropoffImageView.autoPinEdge(toSuperviewMargin: .trailing, withInset: 32)

        dropoffImageView.autoAlignAxis(toSuperviewAxis: .vertical)
        dropoffImageView.autoMatch(.height, to: .width, of: dropoffImageView)
    }

    private func configureBottomStackViewConstraints() {
        bottomStackView.translatesAutoresizingMaskIntoConstraints = false

        bottomStackView.autoPinEdge(toSuperviewMargin: .leading)
        bottomStackView.autoPinEdge(toSuperviewMargin: .trailing)
        bottomStackView.autoPinEdge(toSuperviewMargin: .bottom)
    }
}


