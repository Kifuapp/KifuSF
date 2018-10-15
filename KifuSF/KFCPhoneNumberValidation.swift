//
//  KFCPhoneNumberValidation.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 14/10/2018.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import UIKit

class KFCPhoneNumberValidation: UIViewController {

    let contentScrollView = UIScrollView()
    let outerStackView = UIStackView(axis: .vertical, alignment: .fill, spacing: KFPadding.StackView, distribution: .fill)
    
    let informationLabel = UILabel(font: UIFont.preferredFont(forTextStyle: .body), textColor: .kfSubtitle)
    let authenticationCodeTextFieldContainer = KFTextFieldContainer(textContentType: UITextContentType.oneTimeCode, returnKeyType: .continue, placeholder: "1234")
    let continueButton = KFButton(backgroundColor: .kfPrimary, andTitle: "Continue")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(contentScrollView)
        contentScrollView.addSubview(outerStackView)
        
        configureStyling()
        configureLayoutConstraints()
        configureGestures()
    }
    
    func configureGestures() {
        continueButton.addTarget(self, action: #selector(continueButtonTapped), for: .touchUpInside)
    }
    
    @objc func continueButtonTapped() {
        print("continue")
    }
    
    func configureStyling() {
        view.backgroundColor = .kfSuperWhite
        
        contentScrollView.alwaysBounceVertical = true
        
        title = "Phone Number Validation"
        informationLabel.text = "Almost Done! We've sent a message to your phone number that contains a 4 digit code. Please enter the code below in verify your phone number."
    }
    
    func configureLayoutConstraints() {
        
        configureLayoutForOuterStackView()
        
        configureConstraintsForContentScrollView()
        configureConstraintsForOuterStackView()
    }
    
    func configureLayoutForOuterStackView() {
        outerStackView.addArrangedSubview(informationLabel)
        outerStackView.addArrangedSubview(authenticationCodeTextFieldContainer)
        outerStackView.addArrangedSubview(continueButton)
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
