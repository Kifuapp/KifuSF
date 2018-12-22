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
    private static let descriptionPlaceholder = "Additional Info about pick up address, hour, item, etc."

    private let descriptorView = UIDescriptorView(defaultImageViewSize: .big)
    private let titleInputView = UIGroupView<UITextFieldContainer>(title: "Title",
                                                                   contentView: UITextFieldContainer(returnKeyType: .next,
                                                                                                     placeholder: "Keep it simple"))
    private let descriptionInputView = UIGroupView<UITextView>(title: "Description",
                                                               contentView: UITextView(forAutoLayout: ()))

    private let pickUpAddressButton = UIAnimatedButton(backgroundColor: .kfInformative,
                                                       andTitle: "Choose pick-up address")

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        configureData()
        configureStyling()
        configureLayout()
        configureGestures()
        configureDelegates()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }

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

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        contentScrollView.updateBottomPadding(pickUpAddressButton.frame.height + 24)
    }

    //MARK: - Methods
    @objc func keyboardWillShow(_ notification: Notification) {
        guard let keyboardHeight = notification.getKeyboardHeight() else {
            return assertionFailure("Could not retrieve keyboard height")
        }

        contentScrollView.updateBottomPadding(keyboardHeight + 20)
    }

    //TODO: this method gets called twice find out why
    @objc private  func keyboardWillHide(_ notification: Notification) {
        contentScrollView.updateBottomPadding(pickUpAddressButton.frame.height + 24)
    }

    @objc private func dismissVC() {
        dismiss(animated: true)
    }

    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }

    @objc private func pickUpAddressButtonTapped() {
        print("poof")
    }
}

//MARK: - UITextFieldDelegate
extension CreateDonationViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        descriptionInputView.contentView.becomeFirstResponder()

        return true
    }
}

//MARK: - UITextViewDelegate
extension CreateDonationViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .kfPlaceholderText {
            textView.textColor = .black
            textView.text = nil
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.textColor = .kfPlaceholderText
            textView.text = CreateDonationViewController.descriptionPlaceholder
        }
    }

    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") {
            textView.resignFirstResponder()
            pickUpAddressButtonTapped()
        }

        return true
    }
}

//MARK: - UIConfigurable
extension CreateDonationViewController: UIConfigurable {
    func configureDelegates() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .cancel,
            target: self,
            action: #selector(dismissVC)
        )

        pickUpAddressButton.addTarget(self, action: #selector(pickUpAddressButtonTapped), for: .touchUpInside)

        descriptionInputView.contentView.delegate = self
        titleInputView.contentView.textField.delegate = self
    }

    func configureData() {
        title = "Create Donation"
        descriptorView.titleLabel.text = "Take a photo"
        descriptorView.subtitleStickyLabel.contentView.text = "I don't know"
        descriptionInputView.contentView.text = CreateDonationViewController.descriptionPlaceholder
    }
    
    func configureStyling() {
        view.backgroundColor = .kfSuperWhite

        descriptorView.layer.shadowOpacity = 0

        descriptionInputView.contentView.backgroundColor = .kfGray
        descriptorView.imageView.image = .kfPlusImage

        descriptionInputView.contentView.isScrollEnabled = false
        descriptionInputView.contentView.enablesReturnKeyAutomatically = true
        descriptionInputView.contentView.adjustsFontForContentSizeCategory = true
        descriptionInputView.contentView.returnKeyType = .done

        descriptionInputView.contentView.layer.cornerRadius = CALayer.kfCornerRadius
        descriptionInputView.contentView.font = UIFont.preferredFont(forTextStyle: .title3)
        descriptionInputView.contentView.textColor = .kfPlaceholderText
    }

    func configureLayout() {
        view.addSubview(pickUpAddressButton)

        configureOuterStackViewLayout()

        pickUpAddressButton.autoPinEdge(toSuperviewMargin: .leading)
        pickUpAddressButton.autoPinEdge(toSuperviewMargin: .trailing)
        pickUpAddressButton.autoPinEdge(toSuperviewMargin: .bottom)

        descriptorView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        descriptorView.subtitleStickyLabel.updateStickySide(to: .top)

        descriptionInputView.contentView.autoSetDimension(.height, toSize: 112, relation: .greaterThanOrEqual)
    }

    func configureGestures() {
        let keyboardTap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        keyboardTap.cancelsTouchesInView = false
        view.addGestureRecognizer(keyboardTap)
    }

    private func configureOuterStackViewLayout() {
        outerStackView.addArrangedSubview(descriptorView)
        outerStackView.addArrangedSubview(titleInputView)
        outerStackView.addArrangedSubview(descriptionInputView)
    }
}
