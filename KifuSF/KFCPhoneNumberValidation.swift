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
    let upperStackView = UIStackView(axis: .vertical, alignment: .fill, spacing: KFPadding.ContentView, distribution: .fill)
    
    let informationLabel = UILabel(font: UIFont.preferredFont(forTextStyle: .body), textColor: .kfSubtitle)
    let authenticationCodeTextFieldContainer = UITextFieldContainer(textContentType: .oneTimeCode, returnKeyType: .continue, placeholder: "1234")

    //TODO: implement function to resend code and recheck phone number
    let noCodeLabel = UILabel(font: UIFont.preferredFont(forTextStyle: .body), textColor: .kfPrimary)
    
    let continueButton = UIAnimatedButton(backgroundColor: .kfPrimary, andTitle: "Continue")
    
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
            let authy = authentificator else {
            return
        }
        
        TwoFactorAuthService.validate(code: code, authy: authy) { [unowned self] (succes) in
            if succes {
                UserService.markIsVerifiedTrue(completion: { (isSuccessful) in
                    if isSuccessful {
                        let mainViewControllers = KifuTabBarViewController()
                        self.present(mainViewControllers, animated: true)
                    } else {
                        UIAlertController(errorMessage: nil)
                            .present(in: self)
                    }
                })

                let mainViewControllers = KifuTabBarViewController()
                
                self.present(mainViewControllers, animated: true)
            } else {
                //TODO: show error
            }
        }
    }
    
}

extension KFCPhoneNumberValidation: UIConfigurable {
    func configureGestures() {
        continueButton.addTarget(self, action: #selector(continueButtonTapped), for: .touchUpInside)
    }
    
    func configureStyling() {
        view.backgroundColor = .kfWhite
        
        title = "Phone Number Validation"
        informationLabel.text = "Almost Done! We've sent a message to your phone number that contains a 4 digit code. Please enter the code below in verify your phone number."
        noCodeLabel.text = "Didn't get code?"
        noCodeLabel.textAlignment = .right
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
        outerStackView.addArrangedSubview(continueButton)
    }
}
