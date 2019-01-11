//
//  KFCPhoneNumberValidation.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 14/10/2018.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import UIKit
import Moya

class KFCPhoneNumberValidation: UIScrollableViewController {
    //MARK: - Variables
    let upperStackView = UIStackView(axis: .vertical,
                                     alignment: .fill,
                                     spacing: KFPadding.ContentView,
                                     distribution: .fill)
    
    let informationLabel = UILabel(font: UIFont.preferredFont(forTextStyle: .body),
                                   textColor: UIColor.Text.SubHeadline)
    let authenticationCodeTextFieldContainer = UITextFieldContainer(textContentType: .oneTimeCode,
                                                                    returnKeyType: .continue,
                                                                    placeholder: "1234")

    //TODO: implement function to resend code and recheck phone number
    let noCodeLabel = UILabel(font: UIFont.preferredFont(forTextStyle: .body),
                              textColor: UIColor.Pallete.Green)
    
    let continueButton = UIAnimatedButton(backgroundColor: UIColor.Pallete.Green,
                                          andTitle: "Continue")
    
    let errorLabel = UILabel(font: UIFont.preferredFont(forTextStyle: .footnote),
                                     textColor: UIColor.Pallete.Red)
    
    var authentificator: TwoFactorAuthService.TwoFactorAuthy? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureStyling()
        configureLayout()
        configureGestures()
        
        TwoFactorAuthService.sendTextMessage(to: User.current.contactNumber) { [unowned self] (authy) in
            self.authentificator = authy
        }
    }
    
    @objc func continueButtonTapped() {
        guard let code = authenticationCodeTextFieldContainer.textField.text,
            code.isEmpty == false,
            let authy = authentificator else {
            return showErrorMessage("The code cannot be empty")//TODO: show error (can't be empty)
        }
        
        let loadingVC = KFCLoading(style: .whiteLarge)
        loadingVC.present()
        TwoFactorAuthService.validate(code: code, authy: authy) { [unowned self] (success) in
            if success {
                UserService.markIsVerifiedTrue(completion: { (isSuccessful) in
                    loadingVC.dismiss {
                        if isSuccessful {
                            UserService.updateCurrentUser(
                                key: \User.isVerified, to: true,
                                writeToUserDefaults: false
                            )
                            OnBoardingDistributer.presentNextStepIfNeeded(from: self)
                        } else {
                            UIAlertController(errorMessage: nil)
                                .present(in: self)
                        }
                    }
                })
            } else {
                loadingVC.dismiss {
                    self.showErrorMessage("Incorrect code") //TODO: show error (wrong code)
                }
            }
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
    
    
}

extension KFCPhoneNumberValidation: UIConfigurable {
    func configureGestures() {
        continueButton.addTarget(self, action: #selector(continueButtonTapped), for: .touchUpInside)
    }
    
    func configureStyling() {
        view.backgroundColor = UIColor.Pallete.White
        
        title = "Phone Number Validation"
        informationLabel.text = "Almost Done! We've sent a message to your phone number that contains a 4 digit code. Please enter the code below in verify your phone number."
        noCodeLabel.text = "Didn't get code?"
        noCodeLabel.textAlignment = .right
        errorLabel.textAlignment = .center
    }
    
    func configureLayout() {
        configureLayoutForUpperStackView()
        configureLayoutForOuterStackView()
    }
    
    func configureLayoutForUpperStackView() {
        upperStackView.addArrangedSubview(informationLabel)
        upperStackView.addArrangedSubview(authenticationCodeTextFieldContainer)
        upperStackView.addArrangedSubview(noCodeLabel)
    }
    
    func configureLayoutForOuterStackView() {
        outerStackView.addArrangedSubview(upperStackView)
        outerStackView.addArrangedSubview(errorLabel)
        outerStackView.addArrangedSubview(continueButton)
        
    }
}
