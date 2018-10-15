//
//  KFCLogin.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 13/10/2018.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import UIKit

class KFCLogin: UIViewController, UIConfigurable {
    
    let contentScrollView = UIScrollView()
    
    let outerStackView = UIStackView(axis: .vertical, alignment: .fill, spacing: KFPadding.BigSpacing, distribution: .fill)
    let upperStackView = UIStackView(axis: .vertical, alignment: .fill, spacing: KFPadding.ContentView, distribution: .fill)
    
    let inputStackView = UIStackView(axis: .vertical, alignment: .fill, spacing: KFPadding.StackView, distribution: .fill)
    
    let emailStackView = UIStackView(axis: .vertical, alignment: .fill, spacing: KFPadding.Body, distribution: .fill)
    let emailLabel = UILabel(font: UIFont.preferredFont(forTextStyle: .headline), textColor: .kfTitle)
    let emailTextFieldContainer = KFTextFieldContainer(textContentType: .emailAddress, returnKeyType: .next, placeholder: "me@example.com")
    
    let passwordStackView = UIStackView(axis: .vertical, alignment: .fill, spacing: KFPadding.Body, distribution: .fill)
    let passwordLabel = UILabel(font: UIFont.preferredFont(forTextStyle: .headline), textColor: .kfTitle)
    let passwordTextFieldContainer = KFTextFieldContainer(textContentType: .password, returnKeyType: .done, isSecureTextEntry: true, placeholder: "Password")
    
    let forgotPasswordLabel = UILabel(font: UIFont.preferredFont(forTextStyle: .body), textColor: .kfPrimary)
    
    let logInButton = KFButton(backgroundColor: .kfPrimary, andTitle: "Log In")

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(contentScrollView)
        contentScrollView.addSubview(outerStackView)
        
        configureStyling()
        configureLayoutConstraints()
        
        configureGestures()
        configureTextFieldDelegates()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        NotificationCenter.default.addObserver(self,selector: #selector(keyboardWillShow(_:)),
                                               name: .UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)),
                                               name: .UIKeyboardWillHide, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        let userInfo = notification.userInfo ?? [:]
        let keyboardFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let adjustmentHeight = (keyboardFrame.height + 20)
        
        contentScrollView.updateBottomPadding(adjustmentHeight)
    }
    
    //TODO: this method gets called twice find out why
    @objc func keyboardWillHide(_ notification: Notification) {
        contentScrollView.updateBottomPadding(KFPadding.StackView)
    }
    
    func configureGestures() {
        let keyboardTap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        keyboardTap.cancelsTouchesInView = false
        view.addGestureRecognizer(keyboardTap)
        
        let forgotPasswordTapped = UITapGestureRecognizer(target: self, action: #selector(forgotPasswordButtonTapped))
        forgotPasswordTapped.cancelsTouchesInView = false
        forgotPasswordLabel.addGestureRecognizer(forgotPasswordTapped)
        
        logInButton.addTarget(self, action: #selector(logInButtonTapped), for: .touchUpInside)
    }
    
    @objc func logInButtonTapped() {
        print("log in")
    }
    
    //TODO: show an ui alert
    @objc func forgotPasswordButtonTapped() {
        print("forgot password")
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    private func configureTextFieldDelegates() {
        emailTextFieldContainer.textField.delegate = self
        passwordTextFieldContainer.textField.delegate = self
    }
    
    func configureStyling() {
        title = "Log In"
        view.backgroundColor = .kfSuperWhite
        
        contentScrollView.keyboardDismissMode = .interactive
        contentScrollView.alwaysBounceVertical = true
        contentScrollView.updateBottomPadding(KFPadding.StackView)
        
        emailLabel.text = "Email"
        passwordLabel.text = "Password"
        
        forgotPasswordLabel.text = "Forgot Password?"
        forgotPasswordLabel.textAlignment = .right
        forgotPasswordLabel.isUserInteractionEnabled = true

    }
    
    func configureLayoutConstraints() {
        
        configureLayoutForEmailStackView()
        configureLayoutForPasswordStackView()
        
        configureLayoutForInputStackView()
        configureLayoutForUpperStackView()
        configureLayoutForOuterStackView()
        
        configureConstraintsForContentScrollView()
        configureConstraintsForOuterStackView()
    }
    
    func configureLayoutForUpperStackView() {
        upperStackView.addArrangedSubview(inputStackView)
        upperStackView.addArrangedSubview(forgotPasswordLabel)
    }
    
    func configureLayoutForOuterStackView() {
        outerStackView.addArrangedSubview(upperStackView)
        outerStackView.addArrangedSubview(logInButton)
    }
    
    func configureLayoutForInputStackView() {
        inputStackView.addArrangedSubview(emailStackView)
        inputStackView.addArrangedSubview(passwordStackView)
    }
    
    func configureLayoutForEmailStackView() {
        emailStackView.addArrangedSubview(emailLabel)
        emailStackView.addArrangedSubview(emailTextFieldContainer)
    }
    
    func configureLayoutForPasswordStackView() {
        passwordStackView.addArrangedSubview(passwordLabel)
        passwordStackView.addArrangedSubview(passwordTextFieldContainer)
    }
    
    func configureConstraintsForOuterStackView() {
        outerStackView.translatesAutoresizingMaskIntoConstraints = false
        
        outerStackView.autoMatch(.width, to: .width, of: view, withOffset: -32)
        
        outerStackView.autoPinEdge(toSuperviewEdge: .top, withInset: KFPadding.SuperView)
        outerStackView.autoPinEdge(toSuperviewEdge: .leading, withInset: KFPadding.SuperView)
        outerStackView.autoPinEdge(toSuperviewEdge: .trailing, withInset: KFPadding.SuperView)
        outerStackView.autoPinEdge(toSuperviewEdge: .bottom, withInset: 0)
    }
    
    func configureConstraintsForContentScrollView() {
        contentScrollView.translatesAutoresizingMaskIntoConstraints = false
        contentScrollView.autoPinEdgesToSuperviewEdges()
    }

}

extension KFCLogin: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == emailTextFieldContainer.textField {
            passwordTextFieldContainer.textField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
            logInButtonTapped()
        }
        
        return true
        
    }
}
