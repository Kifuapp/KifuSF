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

    private let buttonsStackView = UIStackView(axis: .vertical, alignment: .fill, spacing: 16, distribution: .fill)
    private let confirmationAnimatedButton = UIAnimatedButton(backgroundColor: .kfPrimary,
                                                              andTitle: "Confirm dropoff")
    private let flagAnimatedButton = UIAnimatedButton(backgroundColor: .kfDestructive,
                                                      andTitle: "Flag Image")

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
    @objc private func dismissVC() {
        dismiss(animated: true)
    }
}

//MARK: - UIConfigurable
extension VerifyDropoffViewController: UIConfigurable {
    func configureDelegates() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .stop,
            target: self,
            action: #selector(dismissVC)
        )
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

        flagDescriptionLabel.numberOfLines = 1
        flagLabel.numberOfLines = 1
    }

    func configureLayout() {
        view.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16)

        view.addSubview(titleLabel)
        view.addSubview(dropoffImageView)
        view.addSubview(buttonsStackView)

        labelsStackView.addArrangedSubview(flagDescriptionLabel)
        labelsStackView.addArrangedSubview(flagLabel)

        buttonsStackView.addArrangedSubview(confirmationAnimatedButton)
        buttonsStackView.addArrangedSubview(labelsStackView)

        flagLabel.setContentHuggingPriority(.init(249), for: .horizontal)

        buttonsStackView.translatesAutoresizingMaskIntoConstraints = false
        buttonsStackView.autoPinEdge(toSuperviewMargin: .leading)
        buttonsStackView.autoPinEdge(toSuperviewMargin: .trailing)
        buttonsStackView.autoPinEdge(toSuperviewMargin: .bottom)

        configureTitleLabelConstraints()
        configureDropoffImageViewConstraints()
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
}


