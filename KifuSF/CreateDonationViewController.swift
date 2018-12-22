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
    private let imageHelper = PhotoHelper()
    private var userSelectedAProfileImage: Bool? = nil

    private let descriptorView = UIDescriptorView(defaultImageViewSize: .big)
    private let titleInputView = UIGroupView<UITextFieldContainer>(title: "Title",
                                                                   contentView: UITextFieldContainer(returnKeyType: .next,
                                                                                                     placeholder: "Keep it simple"))
    private let descriptionInputView = UIGroupView<UITextView>(title: "Description",
                                                               contentView: UITextView(forAutoLayout: ()))
    private let pickUpAddressButton = UIAnimatedButton(backgroundColor: .kfInformative,
                                                       andTitle: "Choose pick-up address")
    private let errorLabel = UILabel(font: UIFont.preferredFont(forTextStyle: .footnote), textColor: .kfDestructive)

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        configureData()
        configureStyling()
        configureLayout()
        configureGestures()
        configureDelegates()

        imageHelper.completionHandler = { [unowned self] (image) in
            self.descriptorView.imageView.image = image
            self.userSelectedAProfileImage = true
        }
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

    @objc private func imageViewTapped() {
        imageHelper.presentActionSheet(from: self)
    }

    @objc private func pickUpAddressButtonTapped() {
        guard let _ = userSelectedAProfileImage,
            let image = descriptorView.imageView.image,
            let title = titleInputView.contentView.textField.text, !title.isEmpty,
            let description = descriptionInputView.contentView.text, description != CreateDonationViewController.descriptionPlaceholder else {
                return showErrorMessage("Please complete all the fields")
        }

//        DonationService.createDonation(
//            title: title,
//            notes: description,
//            image: image,
//            pickUpAddress: location.address,
//            longitude: location.coordinate.longitude,
//            latitude: location.coordinate.latitude) { donation in
//                loadingVc.dismiss {
//                    if donation == nil {
//                        let errorAlert = UIAlertController(errorMessage: nil)
//                        self.present(errorAlert, animated: true)
//                    } else {
//                        self.presentingViewController?.dismiss(animated: true, completion: nil)
//                    }
//                }
//        }
    }

    private func showErrorMessage(_ errorMessage: String) {
        errorLabel.isHidden = false
        errorLabel.text = errorMessage

        UIView.animate(withDuration: UIView.microInteractionDuration, animations: { [unowned self] in
            self.view.layoutIfNeeded()
        }, completion: { [unowned self] (_) in
            self.contentScrollView.scrollToBottom()
        })

        pickUpAddressButton.resetState()
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

        pickUpAddressButton.autoReset = false

        errorLabel.isHidden = true
        errorLabel.textAlignment = .center

        descriptorView.layer.shadowOpacity = 0
        descriptorView.imageView.image = .kfPlusImage

        configureDescriptionInputViewStyling()
    }

    private func configureDescriptionInputViewStyling() {
        descriptionInputView.contentView.isScrollEnabled = false
        descriptionInputView.contentView.enablesReturnKeyAutomatically = true
        descriptionInputView.contentView.adjustsFontForContentSizeCategory = true
        descriptionInputView.contentView.returnKeyType = .done

        descriptionInputView.contentView.layer.cornerRadius = CALayer.kfCornerRadius
        descriptionInputView.contentView.font = UIFont.preferredFont(forTextStyle: .title3)
        descriptionInputView.contentView.textColor = .kfPlaceholderText
        descriptionInputView.contentView.backgroundColor = .kfGray
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

        let imageTapGesture = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped))
        descriptorView.imageView.isUserInteractionEnabled = true
        descriptorView.imageView.addGestureRecognizer(imageTapGesture)
    }

    private func configureOuterStackViewLayout() {
        outerStackView.addArrangedSubview(descriptorView)
        outerStackView.addArrangedSubview(titleInputView)
        outerStackView.addArrangedSubview(descriptionInputView)
        outerStackView.addArrangedSubview(errorLabel)
    }
}
