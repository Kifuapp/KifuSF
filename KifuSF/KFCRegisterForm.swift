//
//  KFCRegisterForm.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 07/10/2018.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import UIKit
import PureLayout
import FirebaseAuth


class KFCRegisterForm: UIViewController {
    
    let contentScrollView = UIScrollView()
    
    let outerStackView = UIStackView(axis: .vertical, alignment: .fill, spacing: KFPadding.BigSpacing, distribution: .fill)
    let upperStackView = UIStackView(axis: .vertical, alignment: .fill, spacing: KFPadding.ContentView, distribution: .fill)
    
    let inputStackView = UIStackView(axis: .vertical, alignment: .fill, spacing: KFPadding.StackView, distribution: .fill)
    
    let profileImageStackView = UIStackView(axis: .vertical, alignment: .fill, spacing: KFPadding.Body, distribution: .fill)
    let profileImageLabel = UILabel(font: UIFont.preferredFont(forTextStyle: .headline), textColor: .kfTitle)
    
    let horizontalImageStackView = UIStackView(axis: .horizontal, alignment: .fill, spacing: KFPadding.Body, distribution: .fill)
    let profileImageView = UIImageView(image: .kfPlusImage)
    let profileImageSpacer = UIView()
    
    let profileImageHelper = PhotoHelper()
    var userSelectedProfileImage: Bool? = nil
    
    let fullNameStackView = UIStackView(axis: .vertical, alignment: .fill, spacing: KFPadding.Body, distribution: .fill)
    let fullNameLabel = UILabel(font: UIFont.preferredFont(forTextStyle: .headline), textColor: .kfTitle)
    let fullNameTextFieldContainer = KFTextFieldContainer(textContentType: .name, returnKeyType: .next, placeholder: "Kifu SF")
    
    let usernameStackView = UIStackView(axis: .vertical, alignment: .fill, spacing: KFPadding.Body, distribution: .fill)
    let usernameLabel = UILabel(font: UIFont.preferredFont(forTextStyle: .headline), textColor: .kfTitle)
    let usernameTextFieldContainer = KFTextFieldContainer(textContentType: .nickname, returnKeyType: .next, placeholder: "@Username")
    
    let phoneNumberStackView = UIStackView(axis: .vertical, alignment: .fill, spacing: KFPadding.Body, distribution: .fill)
    let phoneNumberLabel = UILabel(font: UIFont.preferredFont(forTextStyle: .headline), textColor: .kfTitle)
    let phoneNumberTextFieldContainer = KFTextFieldContainer(textContentType: .telephoneNumber, returnKeyType: .next, placeholder: "+12345678")
    
    let emailStackView = UIStackView(axis: .vertical, alignment: .fill, spacing: KFPadding.Body, distribution: .fill)
    let emailLabel = UILabel(font: UIFont.preferredFont(forTextStyle: .headline), textColor: .kfTitle)
    let emailTextFieldContainer = KFTextFieldContainer(textContentType: .username, returnKeyType: .next, keyboardType: .emailAddress, placeholder: "me@example.com")
    
    let passwordStackView = UIStackView(axis: .vertical, alignment: .fill, spacing: KFPadding.Body, distribution: .fill)
    let passwordLabel = UILabel(font: UIFont.preferredFont(forTextStyle: .headline), textColor: .kfTitle)
    let passwordTextFieldContainer = KFTextFieldContainer(textContentType: .newPassword, returnKeyType: .done, isSecureTextEntry: true, placeholder: "Password")
    
    let disclaimerLabel = UILabel(font: UIFont.preferredFont(forTextStyle: .footnote), textColor: .kfBody)
    let errorLabel = UILabel(font: UIFont.preferredFont(forTextStyle: .footnote), textColor: .kfDestructive)
    
    let continueButton = KFButton(backgroundColor: .kfPrimary, andTitle: "Sign up")
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(contentScrollView)
        contentScrollView.addSubview(outerStackView)

        configureStyling()
        configureLayoutConstraints()
        
        configureDelegates()
        configureGestures()
        
        profileImageHelper.completionHandler = { [unowned self] (image) in
            self.profileImageView.image = image
            self.userSelectedProfileImage = true
        }
    }
    
    @objc func profileImageTapped() {
        profileImageHelper.presentActionSheet(from: self)
        print("tapp")
    }
    
    @objc func continueButtonTapped() {
        guard let fullName = fullNameTextFieldContainer.textField.text,
            let username = usernameTextFieldContainer.textField.text,
            let image = profileImageView.image,
            let _ = userSelectedProfileImage,
            let contactNumber = phoneNumberTextFieldContainer.textField.text,
            let email = emailTextFieldContainer.textField.text,
            let password = passwordTextFieldContainer.textField.text else {
                let errorAlertController = UIAlertController(errorMessage: "Please complete all the fields")
                return present(errorAlertController, animated: true)
        }
        
        //TODO: create validation factory/object
        
        //TODO: check for unique username
        
        
        
        UserService.register(with: fullName, username: username, image: image, contactNumber: contactNumber, email: email, password: password) { [unowned self] (user, error) in
            
            guard let user = user else {
                
                //check if we have an error when the user is nil
                guard let error = error,
                    let errorCode = AuthErrorCode(rawValue: (error._code)) else {
                    fatalError("somebody is dumb")
                }
                
                
                //TODO:decouple error code from closure
                switch errorCode {
                case .weakPassword:
                    self.errorLabel.text = "Password should contain atleast 6 characters."
                case .emailAlreadyInUse:
                    self.errorLabel.text = "This email is already in use."
                case .missingEmail:
                    self.errorLabel.text = "Missing email."
                case .invalidEmail:
                    self.errorLabel.text = "This email is invalid"
                default:
                    self.errorLabel.text = "Something went wront, please try again."
                }
                
                self.errorLabel.isHidden = false
                UIView.animate(withDuration: 0.25, animations: {
                    self.view.layoutIfNeeded()
                })
                
                return
            }
            
            User.setCurrent(user, writeToUserDefaults: false)
            
            let disclaimerViewController = UINavigationController(rootViewController: KFCLocationServiceDisclaimer())
            self.present(disclaimerViewController, animated: true)
        }
        
        
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
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
}

extension KFCRegisterForm: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let nextTextFieldTag = textField.tag + 1
        
        switch nextTextFieldTag {
        case 1:
            usernameTextFieldContainer.textField.becomeFirstResponder()
        case 2:
            phoneNumberTextFieldContainer.textField.becomeFirstResponder()
        case 3:
            emailTextFieldContainer.textField.becomeFirstResponder()
        case 4:
            passwordTextFieldContainer.textField.becomeFirstResponder()
        case 5:
            continueButtonTapped()
            fallthrough
        default:
            textField.resignFirstResponder()
        }
        
        return true
    }
}

extension KFCRegisterForm: UIConfigurable {
    
    func configureDelegates() {
        fullNameTextFieldContainer.textField.delegate = self
        usernameTextFieldContainer.textField.delegate = self
        phoneNumberTextFieldContainer.textField.delegate = self
        emailTextFieldContainer.textField.delegate = self
        passwordTextFieldContainer.textField.delegate = self
    }
    
    func configureStyling() {
        
        view.backgroundColor = .kfSuperWhite
        
        contentScrollView.keyboardDismissMode = .interactive
        contentScrollView.alwaysBounceVertical = true
        contentScrollView.updateBottomPadding(KFPadding.StackView)
        
        profileImageView.makeItKifuStyle()
        profileImageView.isUserInteractionEnabled = true
        
        errorLabel.isHidden = true
        errorLabel.textAlignment = .center
        
        fullNameTextFieldContainer.setTag(0)
        usernameTextFieldContainer.setTag(1)
        phoneNumberTextFieldContainer.setTag(2)
        emailTextFieldContainer.setTag(3)
        passwordTextFieldContainer.setTag(4)
        
        configureText()
    }
    
    func configureText() {
        title = "Register Form"
        profileImageLabel.text = "Profile Image"
        fullNameLabel.text = "Full Name"
        usernameLabel.text = "Username"
        phoneNumberLabel.text = "Phone Number"
        emailLabel.text = "Email"
        passwordLabel.text = "Password"
        disclaimerLabel.text = "By signing up you agree to our Terms and Privacy Policy."
    }
    
    func configureGestures() {
        let keyboardTap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        keyboardTap.cancelsTouchesInView = false
        view.addGestureRecognizer(keyboardTap)
        
        let profileImageTap = UITapGestureRecognizer(target: self, action: #selector(profileImageTapped))
        profileImageTap.cancelsTouchesInView = false
        profileImageView.addGestureRecognizer(profileImageTap)
        
        continueButton.addTarget(self, action: #selector(continueButtonTapped), for: .touchUpInside)
    }
    
    func configureLayoutConstraints() {
        
        configureLayoutForProfileImageView()
        configureLayoutForFullNameStackView()
        configureLayoutForUsernameStackView()
        configureLayoutForPhoneNumberStackView()
        configureLayoutForEmailStackView()
        configureLayoutForPasswordStackView()
        
        configureLayoutForInputStackView()
        configureLayoutForUpperStackView()
        configureLayoutForOuterStackView()
        
        configureConstraintsForContentScrollView()
        configureConstraintsForOuterStackView()
        configureConstraintsForProfileImageView()
    }
    
    func configureConstraintsForProfileImageView() {
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        
        profileImageView.autoMatch(.width, to: .height, of: profileImageView)
        profileImageView.autoSetDimension(.height, toSize: KFPadding.SmallPictureLength)
        
        profileImageSpacer.setContentCompressionResistancePriority(.init(rawValue: 249), for: .horizontal)
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
    
    func configureLayoutForOuterStackView() {
        outerStackView.addArrangedSubview(upperStackView)
        outerStackView.addArrangedSubview(errorLabel)
        outerStackView.addArrangedSubview(continueButton)
    }
    
    func configureLayoutForUpperStackView() {
        upperStackView.addArrangedSubview(inputStackView)
        upperStackView.addArrangedSubview(disclaimerLabel)
    }
    
    func configureLayoutForInputStackView() {
        inputStackView.addArrangedSubview(profileImageStackView)
        inputStackView.addArrangedSubview(fullNameStackView)
        inputStackView.addArrangedSubview(usernameStackView)
        inputStackView.addArrangedSubview(phoneNumberStackView)
        inputStackView.addArrangedSubview(emailStackView)
        inputStackView.addArrangedSubview(passwordStackView)
    }
    
    func configureLayoutForProfileImageView() {
        horizontalImageStackView.addArrangedSubview(profileImageView)
        horizontalImageStackView.addArrangedSubview(profileImageSpacer)
        
        profileImageStackView.addArrangedSubview(profileImageLabel)
        profileImageStackView.addArrangedSubview(horizontalImageStackView)
    }
    
    func configureLayoutForFullNameStackView() {
        fullNameStackView.addArrangedSubview(fullNameLabel)
        fullNameStackView.addArrangedSubview(fullNameTextFieldContainer)
    }
    
    func configureLayoutForUsernameStackView() {
        usernameStackView.addArrangedSubview(usernameLabel)
        usernameStackView.addArrangedSubview(usernameTextFieldContainer)
    }
    
    func configureLayoutForPhoneNumberStackView() {
        phoneNumberStackView.addArrangedSubview(phoneNumberLabel)
        phoneNumberStackView.addArrangedSubview(phoneNumberTextFieldContainer)
    }
    
    func configureLayoutForEmailStackView() {
        emailStackView.addArrangedSubview(emailLabel)
        emailStackView.addArrangedSubview(emailTextFieldContainer)
    }
    
    func configureLayoutForPasswordStackView() {
        passwordStackView.addArrangedSubview(passwordLabel)
        passwordStackView.addArrangedSubview(passwordTextFieldContainer)
    }
}
