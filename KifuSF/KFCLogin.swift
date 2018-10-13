//
//  KFCLogin.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 13/10/2018.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import UIKit

class KFCLogin: UIViewController, Configurable {
    
    let contentScrollView = UIScrollView()
    
    let outerStackView = UIStackView(axis: .vertical, alignment: .fill, spacing: KFPadding.BigSpacing, distribution: .fill)
    let upperStackView = UIStackView(axis: .vertical, alignment: .fill, spacing: KFPadding.ContentView, distribution: .fill)
    
    let inputStackView = UIStackView(axis: .vertical, alignment: .fill, spacing: KFPadding.StackView, distribution: .fill)
    
    let emailStackView = UIStackView(axis: .vertical, alignment: .fill, spacing: KFPadding.Body, distribution: .fill)
    let emailLabel = KFLabel(font: UIFont.preferredFont(forTextStyle: .headline), textColor: .kfTitle)
    let emailTextField = KFTextField()
    
    let passwordStackView = UIStackView(axis: .vertical, alignment: .fill, spacing: KFPadding.Body, distribution: .fill)
    let passwordLabel = KFLabel(font: UIFont.preferredFont(forTextStyle: .headline), textColor: .kfTitle)
    let passwordTextField = KFTextField()
    
    let forgotPasswordLabel = KFLabel(font: UIFont.preferredFont(forTextStyle: .body), textColor: .kfPrimary)
    
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
        
        contentScrollView.contentInset.bottom = adjustmentHeight
        contentScrollView.scrollIndicatorInsets.bottom = adjustmentHeight
    }
    
    //TODO: this method gets called twice find out why
    @objc func keyboardWillHide(_ notification: Notification) {
        contentScrollView.contentInset.bottom = 0
        contentScrollView.scrollIndicatorInsets.bottom = 0
    }
    
    func configureGestures() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    private func configureTextFieldDelegates() {
        emailTextField.contentView.delegate = self
        passwordTextField.contentView.delegate = self
    }
    
    func configureStyling() {
        title = "Log In"
        view.backgroundColor = .kfSuperWhite
        
        contentScrollView.keyboardDismissMode = .onDrag
        contentScrollView.alwaysBounceVertical = true
        
        emailLabel.text = "Email"
        configureStylingForEmailTextField()
        
        passwordLabel.text = "Password"
        configureStylingForPasswordTextField()
        
        forgotPasswordLabel.text = "Forgot Password?"
        forgotPasswordLabel.textAlignment = .right

    }
    
    func configureStylingForEmailTextField() {
        emailTextField.contentView.textContentType = UITextContentType.emailAddress
        emailTextField.contentView.enablesReturnKeyAutomatically = true
        emailTextField.contentView.returnKeyType = .next
        emailTextField.contentView.placeholder = "Email"
    }
    
    func configureStylingForPasswordTextField() {
        passwordTextField.contentView.textContentType = UITextContentType.password
        passwordTextField.contentView.enablesReturnKeyAutomatically = true
        passwordTextField.contentView.returnKeyType = .done
        passwordTextField.contentView.isSecureTextEntry = true
        passwordTextField.contentView.placeholder = "Password"
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
        emailStackView.addArrangedSubview(emailTextField)
    }
    
    func configureLayoutForPasswordStackView() {
        passwordStackView.addArrangedSubview(passwordLabel)
        passwordStackView.addArrangedSubview(passwordTextField)
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
        
        if textField == emailTextField.contentView {
            passwordTextField.contentView.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        
        return true
        
    }
}
