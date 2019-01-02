//
//  ReviewCollaboratorViewController.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 29/12/2018.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import UIKit
import Cosmos

protocol ReviewCollaboratorViewControllerDelegate: class {
    func review(_ reviewCollaborator: ReviewCollaboratorViewController, didFinishReview review: UserReview)
}

class ReviewCollaboratorViewController: UIScrollableViewController {
    //MARK: - Variables
    var volunteer: User?
    var donator: User?
    
    weak var delegate: ReviewCollaboratorViewControllerDelegate?
    
    private let reviewCollaboratorInfoDescriptorView = ReviewCollaboratorDescriptorView(forAutoLayout: ())
    private let sumbitAnimatedButton = UIAnimatedButton(backgroundColor: UIColor.Pallete.Green,
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
        
        // validate rating
        guard let rating = self.rating else {
            return
        }
        
        let roundedInt = Int(rating)
        guard let review = UserReview(numberOfStars: roundedInt) else {
            fatalError("invalid number of stars")
        }
        
        // upload review
        let callback: (Bool) -> Void = { (isSuccessful) in
            if isSuccessful {
                self.delegate?.review(self, didFinishReview: review)
                self.presentingViewController?.dismiss(animated: true)
            } else {
                UIAlertController(errorMessage: nil)
                    .present(in: self)
            }
        }
        
        if let volunteer = self.volunteer {
            UserService.review(volunteer: volunteer, rating: review, completion: callback)
        } else if let donator = self.donator {
            UserService.review(donator: donator, rating: review, completion: callback)
        } else {
            fatalError("need to inject either a donator or volunteer")
        }
    }
}

//MARK: - UIConfigurable
extension ReviewCollaboratorViewController: UIConfigurable {
    func configureDelegates() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: .kfCloseIcon,
            style: .plain,
            target: self,
            action: #selector(dismissViewController)
        )

        sumbitAnimatedButton.addTarget(
            self,
            action: #selector(submitAnimatedButtonTapped),
            for: .touchUpInside
        )

        reviewCollaboratorInfoDescriptorView.cosmosView.didFinishTouchingCosmos = { [unowned self] rating in
            self.rating = rating
        }
    }

    func configureData() {
        title = "Review"
        reviewCollaboratorInfoDescriptorView.motivationalLabel.text =
            ReviewCollaboratorDescriptorView.motivationalMessages.first
        
        let collaborator: User
        if let volunteer = self.volunteer {
            collaborator = volunteer
        } else if let donator = self.donator {
            collaborator = donator
        } else {
            fatalError("need to inject either a donator or volunteer")
        }
        
        let info = KFMCollaboratorInfo(from: collaborator)
        reviewCollaboratorInfoDescriptorView.reloadData(for: info)
    }

    func configureStyling() {
        view.backgroundColor = UIColor.Pallete.Gray
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
