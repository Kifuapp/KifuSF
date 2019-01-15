//
//  KFCFrontPage.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 07/10/2018.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import UIKit
import GoogleSignIn
import FirebaseAuth

class FrontPageViewController: UIViewController, GIDSignInUIDelegate {
    //MARK: - Variables
    private let logoImageView = UIImageView(image: UIImage.kfLogoRegister)
    
    private let bottomStackView = UIStackView(axis: .vertical,
                                              alignment: .fill,
                                              spacing: KFPadding.StackView,
                                              distribution: .fill)
    
    private let registerButton = UIAnimatedButton(backgroundColor: UIColor.Pallete.Green,
                                                  andTitle: "Register")
    private let googleSignInButton = GIDSignInButton()
    
    private let labelsStackView = UIStackView(axis: .horizontal,
                                              alignment: .fill,
                                              spacing: KFPadding.Body,
                                              distribution: .fill)
    
    private let oldUserLabel = UILabel(font: UIFont.preferredFont(forTextStyle: .footnote),
                                       textColor: UIColor.Text.Body)
    private let signInLabel = UILabel(font: UIFont.preferredFont(forTextStyle: .footnote),
                                      textColor: UIColor.Pallete.Green)

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureStyling()
        configureLayout()
        
        registerButton.addTarget(self, action: #selector(registerButtonPressed), for: .touchUpInside)
        GIDSignIn.sharedInstance().uiDelegate = self
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(didSignInWithGoogle),
            name: .userDidLoginWithGoogle,
            object: nil
        )
    }
    
    @objc func didSignInWithGoogle(_ notification: NSNotification) {
        let loadingViewController = KFCLoading(style: .whiteLarge)
        loadingViewController.present()

        guard let credentials = notification.userInfo?["credentials"] as? AuthCredential else {
            fatalError("Did not have any login credentials passed")
        }

        UserService.login(with: credentials, existingUserHandler: { (user, error) in
            if let error = error {
                let message = UserService.retrieveAuthErrorMessage(for: error)
                
                let alert = UIAlertController(
                    title: "Sign in using Google",
                    errorMessage: message,
                    dismissTitle: "Dismiss")
                return self.present(alert, animated: true)
            }
            
            guard let user = user else {
                fatalError("Did not correctly get back a user when signed in with google")
            }
            
            // persist the user only in this current session and not in User Defaults
            User.setCurrent(user)

            loadingViewController.dismiss { }
            OnBoardingDistributer.presentNextStepIfNeeded(from: self)
            
        }, newUserHandler: { (loginInfo) in
            let registerVC = RegisterFormViewController()
            registerVC.signInProvderInfo = loginInfo

            loadingViewController.dismiss {}
            self.navigationController?.pushViewController(registerVC, animated: true)
        })
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        let isAccessibilityCategory = traitCollection.preferredContentSizeCategory.isAccessibilityCategory
        if isAccessibilityCategory {
            labelsStackView.axis = .vertical

            oldUserLabel.numberOfLines = 0
            signInLabel.numberOfLines = 0
        } else {
            labelsStackView.axis = .horizontal

            oldUserLabel.numberOfLines = 1
            signInLabel.numberOfLines = 1
        }
    }

    //MARK: - Functions
    @objc func registerButtonPressed() {
        navigationController?.pushViewController(RegisterFormViewController(), animated: true)
    }
    
    @objc func logInButtonTapped() {
        navigationController?.pushViewController(LoginViewController(), animated: true)
    }
}

//MARK: - UIConfigurable
extension FrontPageViewController: UIConfigurable {
    func configureStyling() {
        view.backgroundColor = UIColor.Pallete.White
        logoImageView.contentMode = .scaleAspectFit
        googleSignInButton.style = .wide

        title = "Front Page"
        oldUserLabel.text = "Already have an account?"
        signInLabel.text = "Sign in"
        
        oldUserLabel.numberOfLines = 1
        signInLabel.numberOfLines = 1
    }
    
    func configureLayout() {
        view.directionalLayoutMargins = NSDirectionalEdgeInsetsMake(16, 16, 16, 16)

        view.addSubview(logoImageView)
        view.addSubview(bottomStackView)
        
        configureConstraintsForLogoImageView()
        
        configureLayoutForLabelsStackView()
        configureLayoutForBottomStackView()
        configureConstraintsForBottomStackView()
        
        signInLabel.setContentHuggingPriority(.init(249), for: .horizontal)
        labelsStackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(logInButtonTapped)))
    }
    
    private func configureConstraintsForLogoImageView() {
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        logoImageView.autoPinEdge(toSuperviewMargin: .top)
        logoImageView.autoPinEdge(toSuperviewMargin: .leading)
        logoImageView.autoPinEdge(toSuperviewMargin: .trailing)
    }
    
    private func configureLayoutForLabelsStackView() {
        labelsStackView.addArrangedSubview(oldUserLabel)
        labelsStackView.addArrangedSubview(signInLabel)
    }
    
    private func configureLayoutForBottomStackView() {
        bottomStackView.addArrangedSubview(registerButton)
        bottomStackView.addArrangedSubview(googleSignInButton)
        bottomStackView.addArrangedSubview(labelsStackView)
    }
    
    private func configureConstraintsForBottomStackView() {
        bottomStackView.translatesAutoresizingMaskIntoConstraints = false

        bottomStackView.autoPinEdge(toSuperviewMargin: .bottom)
        bottomStackView.autoPinEdge(toSuperviewMargin: .leading)
        bottomStackView.autoPinEdge(toSuperviewMargin: .trailing)
    }
}
