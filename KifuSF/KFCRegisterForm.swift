//
//  KFCRegisterForm.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 07/10/2018.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import UIKit
import PureLayout

class KFCRegisterForm: UIViewController, Configurable {
    
    let contentsScrollView = UIScrollView()
    
    let outerStackView = UIStackView()
    
    let topStackView = UIStackView()
    let profileImageView = KFVImage()
    
    let trailingStackView = UIStackView()
    let fullNameTextField = UITextField()
    let usernameTextField = UITextField()
    
    let phoneNumberTextField = UITextField()
    let emailTextField = UITextField()
    let passwordTextField = UITextField()
    
    let errorLabel = KFLabel(font: UIFont.preferredFont(forTextStyle: .caption1), textColor: .kfDestructive)
    
    let nextButton = KFButton(backgroundColor: .kfPrimary, andTitle: "Next")
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
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
        
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(contentsScrollView)
        contentsScrollView.addSubview(outerStackView)

        configureStyling()
        configureLayoutConstraints()
        
        phoneNumberTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
    }
    
    func configureStyling() {
        view.backgroundColor = .kfGray
        
        contentsScrollView.keyboardDismissMode = .onDrag
        
        phoneNumberTextField.backgroundColor = .white
        emailTextField.backgroundColor = .white
        passwordTextField.backgroundColor = .white
        
        errorLabel.text = "Complete all fields"
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        let userInfo = notification.userInfo ?? [:]
        let keyboardFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let adjustmentHeight = (keyboardFrame.height + 20)
        
        contentsScrollView.contentInset.bottom += adjustmentHeight
        contentsScrollView.scrollIndicatorInsets.bottom += adjustmentHeight
    }
    
    
    //TODO: this method gets called twice find out why
    @objc func keyboardWillHide(_ notification: Notification) {
        contentsScrollView.contentInset.bottom = 0
        contentsScrollView.scrollIndicatorInsets.bottom = 0
    }
    
    func configureLayoutConstraints() {
        outerStackView.axis = .vertical
        outerStackView.spacing = 16
        
        outerStackView.addArrangedSubview(errorLabel)
        outerStackView.addArrangedSubview(phoneNumberTextField)
        outerStackView.addArrangedSubview(emailTextField)
        outerStackView.addArrangedSubview(passwordTextField)
        outerStackView.addArrangedSubview(nextButton)
        
        contentsScrollView.translatesAutoresizingMaskIntoConstraints = false
        outerStackView.translatesAutoresizingMaskIntoConstraints = false
        
        contentsScrollView.autoPinEdgesToSuperviewEdges()
        outerStackView.autoPinEdgesToSuperviewEdges()
        
        outerStackView.autoMatch(.width, to: .width, of: view)
    }
}

extension KFCRegisterForm: UITextFieldDelegate {
}
