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

class RegisterFormViewController: UIViewController {
    //MARK: - Variables
    var signInProvderInfo: UserService.SignInProviderInfo?
    
    private let contentScrollView = UIScrollView()
    
    private let outerStackView = UIStackView(axis: .vertical, alignment: .fill, spacing: KFPadding.BigSpacing, distribution: .fill)
    private let upperStackView = UIStackView(axis: .vertical, alignment: .fill, spacing: KFPadding.ContentView, distribution: .fill)
    
    private let inputStackView = UIStackView(axis: .vertical, alignment: .fill, spacing: KFPadding.StackView, distribution: .fill)
    
    private let profileImageStackView = UIStackView(axis: .vertical, alignment: .fill, spacing: KFPadding.Body, distribution: .fill)
    private let profileImageLabel = UILabel(font: UIFont.preferredFont(forTextStyle: .headline), textColor: .kfTitle)
    
    private let horizontalImageStackView = UIStackView(axis: .horizontal, alignment: .fill, spacing: KFPadding.Body, distribution: .fill)
    private let profileImageView = UIImageView(image: .kfPlusImage)
    private let profileImageSpacer = UIView()
    
    private let profileImageHelper = PhotoHelper()
    private var userSelectedAProfileImage: Bool? = nil

    private let fullNameInputView = UIInputView(title: "Full Name", placeholder: "Kifu SF",
                                             textContentType: .name, returnKeyType: .next)

    private let usernameInputView = UIInputView(title: "Username", placeholder: "@Pondorasti",
                                                textContentType: .nickname, returnKeyType: .next)

    private let phoneNumberInputView = UIInputView(title: "Phone Number", placeholder: "+12345678",
                                                textContentType: .telephoneNumber, returnKeyType: .next)

    private let emailInputView = UIInputView(title: "Email", placeholder: "example@kifu.com",
                                                   textContentType: .emailAddress, returnKeyType: .next)

    private let passwordInputView = UIInputView(title: "Password", placeholder: "Password",
                                                   textContentType: .newPassword, returnKeyType: .done)
    
    private let disclaimerLabel = UILabel(font: UIFont.preferredFont(forTextStyle: .footnote), textColor: .kfBody)
    private let errorLabel = UILabel(font: UIFont.preferredFont(forTextStyle: .footnote), textColor: .kfDestructive)
    
    private let continueButton = UIAnimatedButton(backgroundColor: .kfPrimary, andTitle: "Sign up")

    //MARK: - Lifecycle
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

        configureStyling()
        configureLayout()
        configureData()
        configureDelegates()
        configureGestures()
        
        profileImageHelper.completionHandler = { [unowned self] (image) in
            self.profileImageView.image = image
            self.userSelectedAProfileImage = true
        }
    }

    @objc func keyboardWillShow(_ notification: Notification) {
        guard let keyboardHeight = notification.getKeyboardHeight() else {
            return assertionFailure("Could not retrieve keyboard height")
        }

        contentScrollView.updateBottomPadding(keyboardHeight + 20)
    }

    //TODO: this method gets called twice find out why
    @objc func keyboardWillHide(_ notification: Notification) {
        contentScrollView.updateBottomPadding(KFPadding.StackView)
    }

    //MARK: - Functions
    @objc func profileImageTapped() {
        profileImageHelper.presentActionSheet(from: self)
    }
    
    @objc func continueButtonTapped() {
        //unwrap all values and make sure the string is not empty
        guard let image = profileImageView.image,
            let _ = userSelectedAProfileImage,
            let fullName = fullNameInputView.textFieldContainer.textField.text, !fullName.isEmpty,
            let username = usernameInputView.textFieldContainer.textField.text, !username.isEmpty,
            let contactNumber = phoneNumberInputView.textFieldContainer.textField.text, !contactNumber.isEmpty,
            let email = emailInputView.textFieldContainer.textField.text, !email.isEmpty,
            let password = passwordInputView.textFieldContainer.textField.text, !password.isEmpty else {
                return showErrorMessage("Please complete all the fields")
        }
        
        //TODO: check for unique username
        UserService.register(with: fullName, username: username, image: image, contactNumber: contactNumber, email: email, password: password) { [unowned self] (user, error) in
            
            //error handling
            guard let user = user else {
                //check if we have an error when the user is nil
                guard let error = error else {
                    fatalError(KFErrorMessage.seriousBug)
                }
                
                let errorMessage = UserService.retrieveAuthErrorMessage(for: error)
                return self.showErrorMessage(errorMessage)
            }
            
            User.setCurrent(user, writeToUserDefaults: true)
            
            let phoneNumberValidationViewController = KFCPhoneNumberValidation()
            self.present(phoneNumberValidationViewController, animated: true)
        }
    }
    
    private func showErrorMessage(_ errorMessage: String) {
        errorLabel.isHidden = false
        errorLabel.text = errorMessage

        UIView.animate(withDuration: UIView.microInteractionDuration, animations: { [unowned self] in
            self.view.layoutIfNeeded()
        })
        
        continueButton.resetState()
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

//MARK: - UITextFieldDelegate
extension RegisterFormViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let nextTextFieldTag = textField.tag + 1
        
        switch nextTextFieldTag {
        case 1:
            usernameInputView.textFieldContainer.textField.becomeFirstResponder()
        case 2:
            phoneNumberInputView.textFieldContainer.textField.becomeFirstResponder()
        case 3:
            emailInputView.textFieldContainer.textField.becomeFirstResponder()
        case 4:
            passwordInputView.textFieldContainer.textField.becomeFirstResponder()
        case 5:
            continueButtonTapped()
            fallthrough
        default:
            textField.resignFirstResponder()
        }
        
        return true
    }
}

//MARK: - UIConfigurable
extension RegisterFormViewController: UIConfigurable {
    func configureDelegates() {
        fullNameInputView.textFieldContainer.textField.delegate = self
        usernameInputView.textFieldContainer.textField.delegate = self
        phoneNumberInputView.textFieldContainer.textField.delegate = self
        emailInputView.textFieldContainer.textField.delegate = self
        passwordInputView.textFieldContainer.textField.delegate = self
    }
    
    func configureStyling() {
        
        view.backgroundColor = .kfSuperWhite
        
        configureContentScrollView()
        
        profileImageView.makeItKifuStyle()
        profileImageView.isUserInteractionEnabled = true
        
        errorLabel.isHidden = true
        errorLabel.textAlignment = .center
        
        continueButton.autoReset = false
        
        fullNameInputView.textFieldContainer.setTag(0)
        usernameInputView.textFieldContainer.setTag(1)
        phoneNumberInputView.textFieldContainer.setTag(2)
        emailInputView.textFieldContainer.setTag(3)
        passwordInputView.textFieldContainer.setTag(4)
        
        configureText()
    }
    
    func configureContentScrollView() {
        contentScrollView.keyboardDismissMode = .interactive
        contentScrollView.alwaysBounceVertical = true
        contentScrollView.updateBottomPadding(KFPadding.StackView)
    }
    
    func configureData() {
        title = "Register Form"
        profileImageLabel.text = "Profile Image"
        disclaimerLabel.text = "By signing up you agree to our Terms and Privacy Policy."
        
        guard let signInProviderInfo = signInProvderInfo else { return }
        
        if let fullName = signInProvderInfo?.displayName {
            fullNameInputView.textFieldContainer.textField.text = fullName
            fullNameInputView.textFieldContainer.isUserInteractionEnabled = false
        }
        
        if let email = signInProvderInfo?.email{
            emailInputView.textFieldContainer.textField.text = email
            emailInputView.textFieldContainer.isUserInteractionEnabled = false
        }
        
        if let profileUrl = signInProviderInfo.photoUrl{
            profileImageView.kf.setImage(with: profileUrl)
        }
        
        if let phoneNumber = signInProviderInfo.phoneNumber{
            phoneNumberInputView.textFieldContainer.textField.text = phoneNumber
            phoneNumberInputView.textFieldContainer.isUserInteractionEnabled = false
        } 
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
    
    func configureLayout() {
        view.addSubview(contentScrollView)

        contentScrollView.addSubview(outerStackView)
        contentScrollView.directionalLayoutMargins.top = 8
        contentScrollView.directionalLayoutMargins.leading = 16
        contentScrollView.directionalLayoutMargins.trailing = 16
        
        configureLayoutForProfileImageView()
        
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
        inputStackView.addArrangedSubview(fullNameInputView)
        inputStackView.addArrangedSubview(usernameInputView)
        inputStackView.addArrangedSubview(phoneNumberInputView)
        inputStackView.addArrangedSubview(emailInputView)
        inputStackView.addArrangedSubview(passwordInputView)
    }
    
    func configureLayoutForProfileImageView() {
        horizontalImageStackView.addArrangedSubview(profileImageView)
        horizontalImageStackView.addArrangedSubview(profileImageSpacer)
        
        profileImageStackView.addArrangedSubview(profileImageLabel)
        profileImageStackView.addArrangedSubview(horizontalImageStackView)
    }
}
