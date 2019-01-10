//
//  VerifyDropoffViewController.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 28/12/2018.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import UIKit

class VerifyDropoffViewController: UIScrollableViewController {
    //MARK: - Variables
    var donation: Donation!
    
    private let backgroundView = UIView(forAutoLayout: ())
    private let titleLabel = UILabel(font: UIFont.preferredFont(forTextStyle: .headline),
                                       textColor: UIColor.Text.Headline)
    private let dropoffImageView = UIImageView(forAutoLayout: ())

    private let bottomStackView = UIStackView(axis: .vertical,
                                              alignment: .fill,
                                              spacing: 16,
                                              distribution: .fill)
    private let confirmationAnimatedButton = UIAnimatedButton(backgroundColor: UIColor.Pallete.Green,
                                                              andTitle: "Confirm dropoff")

    private let labelsStackView = UIStackView(axis: .horizontal,
                                              alignment: .fill,
                                              spacing: 4,
                                              distribution: .fill)

    private let flagDescriptionLabel = UILabel(font: UIFont.preferredFont(forTextStyle: .footnote),
                                               textColor: UIColor.Text.Body)
    private let flagLabel = UILabel(font: UIFont.preferredFont(forTextStyle: .footnote),
                                    textColor: UIColor.Pallete.Red)

    //MARK: - Lifecycle
    override func viewDidLoad() {
        contentDirectionalLayoutMargins = NSDirectionalEdgeInsetsMake(32, 32, 32, 32)

        super.viewDidLoad()

        configureData()
        configureDelegates()
        configureStyling()
        configureLayout()
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        let isAccessibilityCategory = traitCollection.preferredContentSizeCategory.isAccessibilityCategory

        contentScrollView.updateBottomPadding(bottomStackView.frame.height + 24)
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
        UIAlertController(title: "Confirm Dropoff Image", message: "Are you sure you want to confrim this image?", preferredStyle: .actionSheet)
            .addButton(title: "Confirm Delivery", style: .destructive) { [weak self] _ in
                self?.confirmDropoffImage()
            }
            .addCancelButton()
            .present(in: self)
    }
    
    private func confirmDropoffImage() {
        DonationService.verifyDelivery(for: self.donation) { (isSuccessful) in
            if isSuccessful {
                self.presentingViewController?.dismiss(animated: true)
            } else {
                UIAlertController(errorMessage: nil)
                    .present(in: self)
            }
        }
    }

    @objc private func reportButtonTapped() {
        let flaggingViewController = UINavigationController(
            rootViewController: FlaggingViewController(
                flaggableItems: flaggableItems,
                userToReport: donation.donator,
                donationToReport: donation
            )
        )
        navigationController?.pushViewController(flaggingViewController, animated: true)
    }
}

// MARK: - FlaggingContentItems
extension VerifyDropoffViewController: FlaggingContentItems {
    var flaggableItems: [FlaggedContentType] {
        return [.flaggedVerificationImage]
    }
}

//MARK: - UIConfigurable
extension VerifyDropoffViewController: UIConfigurable {
    func configureDelegates() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: .kfCloseIcon,
            style: .plain,
            target: self,
            action: #selector(dismissViewController)
        )

        confirmationAnimatedButton.addTarget(
            self,
            action: #selector(confirmationAnimatedButtonTapped),
            for: .touchUpInside

        )

        labelsStackView.addGestureRecognizer(UITapGestureRecognizer(
            target: self,
            action: #selector(reportButtonTapped))
        )
    }

    func configureData() {
        title = "Security Step"
        titleLabel.text = "Validate Volunteer's image"
        
        guard
            let verificationUrlString = donation.verificationUrl,
            let verificationUrl = URL(string: verificationUrlString) else {
            fatalError("validation needs to happen before this view controller")
        }
        
        dropoffImageView.kf.setImage(with: verificationUrl)

        flagDescriptionLabel.text = "Image not looking right?"
        flagLabel.text = "Tap here to report."
    }

    func configureStyling() {
        view.backgroundColor = UIColor.Pallete.Gray
        titleLabel.textAlignment = .center

        dropoffImageView.makeItKifuStyle()

        //set default styling when accessibility is not present
        flagDescriptionLabel.numberOfLines = 1
        flagLabel.numberOfLines = 1

        configureBackgroundViewStyling()
    }

    func configureBackgroundViewStyling() {
        backgroundView.layer.zPosition = -1
        backgroundView.backgroundColor = UIColor.Pallete.White
        backgroundView.layer.setUpShadow()
        backgroundView.clipsToBounds = false
        backgroundView.layer.cornerRadius = CALayer.kfCornerRadius
    }

    func configureLayout() {
        outerStackView.addArrangedSubview(titleLabel)
        outerStackView.addArrangedSubview(dropoffImageView)
        outerStackView.addSubview(backgroundView)

        view.addSubview(bottomStackView)

        labelsStackView.addArrangedSubview(flagDescriptionLabel)
        labelsStackView.addArrangedSubview(flagLabel)

        bottomStackView.addArrangedSubview(confirmationAnimatedButton)
        bottomStackView.addArrangedSubview(labelsStackView)

        flagLabel.setContentHuggingPriority(.init(249), for: .horizontal)
        flagLabel.setContentCompressionResistancePriority(.init(751), for: .horizontal)

        configureBackgroundViewConstraints()
        configureDropoffImageViewConstraints()
        configureBottomStackViewConstraints()
    }

    private func configureBackgroundViewConstraints() {
        backgroundView.autoPinEdge(.top, to: .top, of: contentScrollView, withOffset: 16)
        backgroundView.autoPinEdge(.leading, to: .leading, of: contentScrollView, withOffset: 16)
        backgroundView.autoPinEdge(.trailing, to: .trailing, of: contentScrollView, withOffset: -16)
        backgroundView.autoPinEdge(.bottom, to: .bottom, of: contentScrollView, withOffset: -16)
    }

    private func configureDropoffImageViewConstraints() {
        dropoffImageView.autoMatch(.height, to: .width, of: dropoffImageView)
    }

    private func configureBottomStackViewConstraints() {
        bottomStackView.translatesAutoresizingMaskIntoConstraints = false

        bottomStackView.autoPinEdge(toSuperviewMargin: .leading, withInset: -16)
        bottomStackView.autoPinEdge(toSuperviewMargin: .trailing, withInset: -16)
        bottomStackView.autoPinEdge(toSuperviewMargin: .bottom, withInset: -16)
    }
}


