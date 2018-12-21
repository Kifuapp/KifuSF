//
//  CreateDonationViewController.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 17/12/2018.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import UIKit

class CreateDonationViewController: UIScrollableViewController {
    //MARK: - Variables
    private let descriptorView = UIDescriptorView(defaultImageViewSize: .big)
    private let titleInputView = UIGroupView<UITextFieldContainer>(title: "Title",
                                                                   contentView: UITextFieldContainer(returnKeyType: .next,
                                                                                                     placeholder: "Keep it simple"))
    private let descriptionInputView = UIGroupView<UITextView>(title: "Description",
                                                               contentView: UITextView())

    private let pickUpAddressButton = UIAnimatedButton(backgroundColor: .kfInformative,
                                                       andTitle: "Choose pick-up address")

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        configureData()
        configureStyling()
        configureLayout()
    }
}

//MARK: - UIConfigurable
extension CreateDonationViewController: UIConfigurable {
    func configureData() {
        title = "Create Donation"
        descriptorView.titleLabel.text = "Take a photo"
        descriptorView.subtitleStickyLabel.contentView.text = "I don't know"
    }
    
    func configureStyling() {
        view.backgroundColor = .kfWhite

        descriptorView.layer.shadowOpacity = 0

        descriptionInputView.contentView.backgroundColor = .kfGray
        descriptorView.imageView.image = .kfPlusImage
        
    }

    func configureLayout() {
        view.addSubview(pickUpAddressButton)

        configureOuterStackViewLayout()

        pickUpAddressButton.autoPinEdge(toSuperviewMargin: .leading)
        pickUpAddressButton.autoPinEdge(toSuperviewMargin: .trailing)
        pickUpAddressButton.autoPinEdge(toSuperviewMargin: .bottom)
    }

    private func configureOuterStackViewLayout() {
        outerStackView.addArrangedSubview(descriptorView)
        outerStackView.addArrangedSubview(titleInputView)
        outerStackView.addArrangedSubview(descriptionInputView)
    }
}
