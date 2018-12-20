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
    private let descriptorView = UIDescriptorView()
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

        configureStyling()
        configureLayout()
    }
}

//MARK: - UIConfigurable
extension CreateDonationViewController: UIConfigurable {
    func configureData() {
        title = "Create Donation"
    }
    
    func configureStyling() {

        view.backgroundColor = UIColor.kfWhite

        descriptionInputView.contentView.backgroundColor = .kfGray
        descriptorView.imageView.image = .kfPlusImage
        descriptorView.titleLabel.text = "Take a photo"
        descriptorView.subtitleStickyLabel.contentView.text = "I don't know"
    }

    func configureLayout() {
        view.addSubview(pickUpAddressButton)

        outerStackView.addArrangedSubview(descriptorView)
        outerStackView.addArrangedSubview(titleInputView)
        outerStackView.addArrangedSubview(descriptionInputView)
    }
}
