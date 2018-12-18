//
//  KFCLogin.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 13/10/2018.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    //MARK: - Variables
    private let contentScrollView = UIScrollView()
    
    private let outerStackView = UIStackView(axis: .vertical, alignment: .fill, spacing: KFPadding.BigSpacing, distribution: .fill)
    private let upperStackView = UIStackView(axis: .vertical, alignment: .fill, spacing: KFPadding.ContentView, distribution: .fill)
    
    private let inputStackView = UIStackView(axis: .vertical, alignment: .fill, spacing: KFPadding.StackView, distribution: .fill)

    private let emailInputView = UIInputView(title: "Email", placeholder: "me@example.com",
                                     textContentType: .emailAddress, returnKeyType: .next)

    private let passwordInputView = UIInputView(title: "Password", placeholder: "Password",
                                        textContentType: .password, returnKeyType: .done)
    
    private let forgotPasswordLabel = UILabel(font: UIFont.preferredFont(forTextStyle: .body), textColor: .kfPrimary)
    private let errorLabel = UILabel(font: UIFont.preferredFont(forTextStyle: .footnote), textColor: .kfDestructive)
    
    private let logInButton = UIAnimatedButton(backgroundColor: .kfPrimary, andTitle: "Log In")

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        configureStyling()
        configureLayout()
        configureGestures()
        configureDelegates()
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
        guard let keyboardHeight = notification.getKeyboardHeight() else {
            return assertionFailure("Could not retrieve keyboard height")
        }
        
        contentScrollView.updateBottomPadding(keyboardHeight + 20)
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        contentScrollView.updateBottomPadding(KFPadding.StackView)
    }

    //MARK: - Functions
    @objc func logInButtonTapped() {
        guard let email = emailInputView.textFieldContainer.textField.text, !email.isEmpty,
            let password = passwordInputView.textFieldContainer.textField.text, !password.isEmpty else {
                return showErrorMessage("Please complete all the fields")
        }
        
        UserService.login(email: email, password: password) { (user, error) in
            guard let user = user else {
                //check if we have an error when the user is nil
                guard let error = error else {
                    fatalError(KFErrorMessage.seriousBug)
                }
                
                let errorMessage = UserService.retrieveAuthErrorMessage(for: error)
                return self.showErrorMessage(errorMessage)
            }
            
            User.setCurrent(user, writeToUserDefaults: true)

            if User.current.isVerified {
                let mainViewControllers = KifuTabBarController()
                self.present(mainViewControllers, animated: true)
            } else {
                let phoneNumberValidationViewController = KFCPhoneNumberValidation()
                self.present(phoneNumberValidationViewController, animated: true)
            }
        }
    }
    
    @objc func forgotPasswordButtonTapped() {
        let ac = UIAlertController(title: "Reset Password", message: "Type your email that is linked to your account and you will receive an email to reset your password", preferredStyle: .alert)
        
        ac.addTextField()
        ac.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: nil))
        ac.addAction(UIAlertAction(title: "Reset", style: .default, handler: { (_) in
            guard let email = ac.textFields?.first?.text else {
                return
            }
            
            UserService.resetPassword(for: email, completion: { (succes) in
                //TODO: maybe handle error
                print(succes)
            })
        }))
        
        present(ac, animated: true)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    private func showErrorMessage(_ errorMessage: String) {
        errorLabel.isHidden = false
        errorLabel.text = errorMessage

        UIView.animate(withDuration: UIView.microInteractionDuration, animations: { [unowned self] in
            self.view.layoutIfNeeded()
        })
        
        logInButton.resetState()
    }
}

//MARK: - UITextFieldDelegate
extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == emailInputView.textFieldContainer.textField {
            passwordInputView.textFieldContainer.textField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
            logInButtonTapped()
        }
        
        return true
    }
}

//MARK: - UIConfigurable
extension LoginViewController: UIConfigurable {
    func configureGestures() {
        let keyboardTap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        keyboardTap.cancelsTouchesInView = false
        view.addGestureRecognizer(keyboardTap)

        let forgotPasswordTapped = UITapGestureRecognizer(target: self, action: #selector(forgotPasswordButtonTapped))
        forgotPasswordTapped.cancelsTouchesInView = false
        forgotPasswordLabel.addGestureRecognizer(forgotPasswordTapped)

        logInButton.addTarget(self, action: #selector(logInButtonTapped), for: .touchUpInside)
    }
    
    func configureDelegates() {
        emailInputView.textFieldContainer.textField.delegate = self
        passwordInputView.textFieldContainer.textField.delegate = self
    }
    
    func configureStyling() {
        title = "Log In"
        
        configureContentScrollViewStyling()
        configureForgotPasswordLabelStyling()
        
        view.backgroundColor = .kfSuperWhite
        
        logInButton.autoReset = false
        
        errorLabel.textAlignment = .center
    }
    
    func configureContentScrollViewStyling() {
        contentScrollView.keyboardDismissMode = .interactive
        contentScrollView.alwaysBounceVertical = true
        contentScrollView.updateBottomPadding(KFPadding.StackView)
    }
    
    func configureForgotPasswordLabelStyling() {
        forgotPasswordLabel.text = "Forgot Password?"
        forgotPasswordLabel.textAlignment = .right
        forgotPasswordLabel.isUserInteractionEnabled = true
    }
    
    func configureLayout() {
        view.addSubview(contentScrollView)

        contentScrollView.addSubview(outerStackView)
        contentScrollView.directionalLayoutMargins.top = 8
        contentScrollView.directionalLayoutMargins.leading = 16
        contentScrollView.directionalLayoutMargins.trailing = 16
        
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
        outerStackView.addArrangedSubview(errorLabel)
        outerStackView.addArrangedSubview(logInButton)
    }
    
    func configureLayoutForInputStackView() {
        inputStackView.addArrangedSubview(emailInputView)
        inputStackView.addArrangedSubview(passwordInputView)
    }

    func configureConstraintsForOuterStackView() {
        outerStackView.translatesAutoresizingMaskIntoConstraints = false
        
        outerStackView.autoMatch(.width, to: .width, of: view,
                                 withOffset: -(contentScrollView.directionalLayoutMargins.leading + contentScrollView.directionalLayoutMargins.trailing))

        outerStackView.autoPinEdge(toSuperviewMargin: .top)
        outerStackView.autoPinEdge(toSuperviewMargin: .leading)
        outerStackView.autoPinEdge(toSuperviewMargin: .trailing)
        outerStackView.autoPinEdge(toSuperviewEdge: .bottom, withInset: 0)
    }
    
    func configureConstraintsForContentScrollView() {
        contentScrollView.translatesAutoresizingMaskIntoConstraints = false
        contentScrollView.autoPinEdgesToSuperviewEdges()
    }
}
