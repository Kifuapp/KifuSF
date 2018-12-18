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

class RegisterFormViewController: UIScrollableViewController {
    //MARK: - Variables
    private let upperStackView = UIStackView(axis: .vertical, alignment: .fill, spacing: KFPadding.ContentView, distribution: .fill)
    
    private let inputStackView = UIStackView(axis: .vertical, alignment: .fill, spacing: KFPadding.StackView, distribution: .fill)
    
    private let profileImageStackView = UIStackView(axis: .vertical, alignment: .fill, spacing: KFPadding.Body, distribution: .fill)
    private let profileImageLabel = UILabel(font: UIFont.preferredFont(forTextStyle: .headline), textColor: .kfTitle)
    
    private let horizontalImageStackView = UIStackView(axis: .horizontal, alignment: .fill, spacing: KFPadding.Body, distribution: .fill)
    private let profileImageView = UIImageView(image: .kfPlusImage)
    private let profileImageSpacer = UIView()
    
    private let profileImageHelper = PhotoHelper()
    private var userSelectedAProfileImage: Bool? = nil

    private let fullNameInputView = UIGroupView<UITextFieldContainer>(title: "Full Name",
                                                                      contentView: UITextFieldContainer(textContentType: .name,
                                                                                                    returnKeyType: .next,
                                                                                                    placeholder: "Kifu SF"))
    private let usernameInputView = UIGroupView<UITextFieldContainer>(title: "Username",
                                                                      contentView: UITextFieldContainer(textContentType: .nickname,
                                                                                                    returnKeyType: .next,
                                                                                                    placeholder: "@Pondorasti"))
    private let phoneNumberInputView = UIGroupView<UITextFieldContainer>(title: "Phone Number",
                                                                         contentView: UITextFieldContainer(textContentType: .telephoneNumber,
                                                                                                       returnKeyType: .next,
                                                                                                       keyboardType: .phonePad,
                                                                                                       placeholder: "+12345678"))
    private let emailInputView = UIGroupView<UITextFieldContainer>(title: "Email",
                                                                   contentView: UITextFieldContainer(textContentType: .emailAddress,
                                                                                                 returnKeyType: .next,
                                                                                                 keyboardType: .emailAddress,
                                                                                                 placeholder: "example@kifu.com"))
    private let passwordInputView = UIGroupView<UITextFieldContainer>(title: "Password",
                                                                      contentView: UITextFieldContainer(textContentType: .newPassword,
                                                                                                    returnKeyType: .done,
                                                                                                    isSecureTextEntry: true,
                                                                                                    placeholder: "Password"))
    
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
            let fullName = fullNameInputView.contentView.textField.text, !fullName.isEmpty,
            let username = usernameInputView.contentView.textField.text, !username.isEmpty,
            let phoneNumber = phoneNumberInputView.contentView.textField.text, !phoneNumber.isEmpty,
            let email = emailInputView.contentView.textField.text, !email.isEmpty,
            let password = passwordInputView.contentView.textField.text, !password.isEmpty else {
                return showErrorMessage("Please complete all the fields")
        }

        let normalizedPhoneNumber = phoneNumber.deleteOccurrences(of: ["(", ")", " "])
        //TODO: check for unique username
        UserService.register(with: fullName, username: username, image: image, contactNumber: normalizedPhoneNumber, email: email, password: password) { [unowned self] (user, error) in
            
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
            usernameInputView.contentView.textField.becomeFirstResponder()
        case 2:
            phoneNumberInputView.contentView.textField.becomeFirstResponder()
        case 3:
            emailInputView.contentView.textField.becomeFirstResponder()
        case 4:
            passwordInputView.contentView.textField.becomeFirstResponder()
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
        fullNameInputView.contentView.textField.delegate = self
        usernameInputView.contentView.textField.delegate = self
        phoneNumberInputView.contentView.textField.delegate = self
        emailInputView.contentView.textField.delegate = self
        passwordInputView.contentView.textField.delegate = self
    }
    
    func configureStyling() {
        view.backgroundColor = .kfSuperWhite
        contentScrollView.updateBottomPadding(KFPadding.StackView)
        
        profileImageView.makeItKifuStyle()
        profileImageView.isUserInteractionEnabled = true
        
        errorLabel.isHidden = true
        errorLabel.textAlignment = .center
        
        continueButton.autoReset = false
        
        fullNameInputView.contentView.setTag(0)
        usernameInputView.contentView.setTag(1)
        phoneNumberInputView.contentView.setTag(2)
        emailInputView.contentView.setTag(3)
        passwordInputView.contentView.setTag(4)
        
        configureText()
    }
    
    func configureText() {
        title = "Register Form"
        profileImageLabel.text = "Profile Image"
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
    
    func configureLayout() {
        configureLayoutForProfileImageView()
        
        configureLayoutForInputStackView()
        configureLayoutForUpperStackView()
        configureLayoutForOuterStackView()

        configureConstraintsForProfileImageView()
    }
    
    func configureConstraintsForProfileImageView() {
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        
        profileImageView.autoMatch(.width, to: .height, of: profileImageView)
        profileImageView.autoSetDimension(.height, toSize: KFPadding.SmallPictureLength)
        
        profileImageSpacer.setContentCompressionResistancePriority(.init(rawValue: 249), for: .horizontal)
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
