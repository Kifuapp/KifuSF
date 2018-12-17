//
//  CreateDonationViewController.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 17/12/2018.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import UIKit

class CreateDonationViewController: UIViewController {

    private let contentScrollView = UIScrollView()
    private let outerStackView = UIStackView()

    private let descriptorView = UIDescriptorView()
    private let titleInputView = UIGroupView<UITextFieldContainer>(title: "Title",
                                                                   contentView: UITextFieldContainer(returnKeyType: .next,
                                                                                                     placeholder: "Keep it simple"))
    private let descriptionInputView = UIGroupView<UITextView>(title: "Description",
                                                               contentView: UITextView())

    private let pickUpAddressButton = UIAnimatedButton(backgroundColor: .kfInformative,
                                                       andTitle: "Choose pick-up address")

    override func viewDidLoad() {
        super.viewDidLoad()

        configureStyling()
        configureLayout()
    }
}

//MARK: - UIConfigurable
extension CreateDonationViewController: UIConfigurable {
    func configureStyling() {

    }

    func configureLayout() {
        view.addSubview(contentScrollView)
        view.addSubview(pickUpAddressButton)

        contentScrollView.directionalLayoutMargins.leading = 16
        contentScrollView.directionalLayoutMargins.trailing = 16

        contentScrollView.addSubview(outerStackView)

        outerStackView.addArrangedSubview(descriptorView)
        outerStackView.addArrangedSubview(titleInputView)
        outerStackView.addArrangedSubview(descriptionInputView)

        outerStackView.autoMatch(.width, to: .width, of: view, withOffset: -(contentScrollView.directionalLayoutMargins.leading + contentScrollView.directionalLayoutMargins.trailing))
        outerStackView.autoPinEdgesToSuperviewMargins()


    }
}
