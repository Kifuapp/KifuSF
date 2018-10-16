//
//  KFCFrontPage.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 07/10/2018.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import UIKit
import GoogleSignIn

class KFCFrontPage: UIViewController, GIDSignInUIDelegate {
    
    let logoImageView = UIImageView(image: UIImage.kfLogo)
    
    let bottomStackView = UIStackView(axis: .vertical, alignment: .fill, spacing: KFPadding.StackView, distribution: .fill)
    
    let registerButton = KFButton(backgroundColor: .kfPrimary, andTitle: "Register")
    let googleSignInButton = GIDSignInButton()
    
    let labelsStackView = UIStackView(axis: .horizontal, alignment: .fill, spacing: KFPadding.Body, distribution: .fill)
    
    let oldUserLabel = UILabel(font: UIFont.preferredFont(forTextStyle: .footnote), textColor: .kfBody)
    let signInLabel = UILabel(font: UIFont.preferredFont(forTextStyle: .footnote), textColor: .kfPrimary)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureStyling()
        configureLayoutConstraints()
        
        registerButton.addTarget(self, action: #selector(registerButtonPressed), for: .touchUpInside)
        
        GIDSignIn.sharedInstance().uiDelegate = self
    }
    
    @objc func registerButtonPressed() {
        navigationController?.pushViewController(KFCRegisterForm(), animated: true)
        registerButton.resetState()
        
    }
    
    @objc func logInButtonTapped() {
        navigationController?.pushViewController(KFCLogin(), animated: true)
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
}

extension KFCFrontPage: UIConfigurable {
    
    func configureStyling() {
        title = "Front Page"
        view.backgroundColor = .kfSuperWhite
        
        logoImageView.contentMode = .scaleAspectFit
        
        googleSignInButton.style = .wide
        
        oldUserLabel.text = "Already have an account?"
        signInLabel.text = "Sign in"
        
        oldUserLabel.numberOfLines = 1
        signInLabel.numberOfLines = 1
    }
    
    func configureLayoutConstraints() {
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
        
        logoImageView.autoPinEdge(toSuperviewEdge: .top, withInset: 16)
        logoImageView.autoPinEdge(toSuperviewEdge: .leading, withInset: 16)
        logoImageView.autoPinEdge(toSuperviewEdge: .trailing, withInset: 16)
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
        
        bottomStackView.autoPinEdge(toSuperviewEdge: .bottom, withInset: 16)
        bottomStackView.autoPinEdge(toSuperviewEdge: .leading, withInset: 16)
        bottomStackView.autoPinEdge(toSuperviewEdge: .trailing, withInset: 24)
    }
}
