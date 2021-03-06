//
//  CreateDonationViewController.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 17/12/2018.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import UIKit
import LocationPicker

class CreateDonationViewController: UIScrollableViewController {
    //MARK: - Variables
    private static let descriptionPlaceholder = "Additional info about pick up address, hours of availability, item description."

    private lazy var imageHelper = PhotoHelper()
    private let keyboardStack = KeyboardHandler()

    private var userSelectedAProfileImage: Bool? = nil
    private var pickupLocation: Location?

    private let descriptorView = UIDescriptorView(defaultImageViewSize: .medium)
    private let titleInputView: UIGroupView<UITextFieldContainer> = {
        let container = UITextFieldContainer(returnKeyType: .next,
                                             placeholder: "Keep it simple")
        container.textField.autocorrectionType = .default
        container.textField.autocapitalizationType = .words
        
        return UIGroupView<UITextFieldContainer>(title: "Item Name",
                                                 contentView: container)
    }()
    
    private let descriptionInputView = UIGroupView<UITextView>(title: "Description",
                                                               contentView: UITextView(forAutoLayout: ()))
    private let pickUpAddressButton = UIAnimatedButton(backgroundColor: UIColor.Pallete.Blue,
                                                       andTitle: "Choose pick-up address")
    private let errorLabel = UILabel(font: UIFont.preferredFont(forTextStyle: .footnote),
                                     textColor: UIColor.Pallete.Red)

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

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        contentScrollView.updateBottomPadding(pickUpAddressButton.frame.height + 24)
    }

    //MARK: - Methods
    @objc private func dismissViewController() {
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

        let locationPicker = retrieveLocationPicker()
        let loadingVC = KFCLoading(style: .whiteLarge)
        locationPicker.completion = { [unowned self] location in
            guard let location = location else {
                return assertionFailure(KFErrorMessage.seriousBug)
            }
            
            self.pickupLocation = location
            
            loadingVC.present()
            DonationService.createDonation(
                title: title,
                notes: description,
                image: image,
                pickUpAddress: location.address,
                longitude: location.coordinate.longitude,
                latitude: location.coordinate.latitude) { [unowned self] donation in
                    loadingVC.dismiss {
                        guard let _ = donation else {
                            let errorAlert = UIAlertController(errorMessage: nil)
                            return self.present(errorAlert, animated: true)
                        }
                        
                        self.presentingViewController?.dismiss(animated: true)
                    }
            }
        }

        self.navigationController?.pushViewController(locationPicker, animated: true)
    }
    
    @objc private func donationRequirementsButtonPressed(){
        let requirementsVC = DonationRequirementsViewController()
        self.navigationController?.pushViewController(requirementsVC, animated: true)
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
        if textView.textColor == UIColor.Text.Placeholder {
            textView.textColor = .black
            textView.text = nil
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.textColor = UIColor.Text.Placeholder
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

//MARK: - KeyboardHandlerDelegate
extension CreateDonationViewController: KeyboardHandlerDelegate {
    func keyboard(_ keyboard: KeyboardHandler, didChangeTo newHeight: CGFloat) {
        if newHeight == 0 {
            contentScrollView.updateBottomPadding(pickUpAddressButton.frame.height + 24)
        } else {
            contentScrollView.updateBottomPadding(newHeight + 20)
        }
    }
}

//MARK: - UIConfigurable
extension CreateDonationViewController: UIConfigurable {
    private func retrieveLocationPicker() -> LocationPickerViewController {
        let locationPicker = LocationPickerViewController()
        locationPicker.showCurrentLocationInitially = true
        locationPicker.searchBarPlaceholder = "Choose Pickup location"
        locationPicker.mapType = .standard
        locationPicker.showCurrentLocationButton = true

        return locationPicker
    }

    func configureDelegates() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: .kfCloseIcon,
            style: .plain,
            target: self,
            action: #selector(dismissViewController)
        )

        pickUpAddressButton.addTarget(
            self,
            action: #selector(pickUpAddressButtonTapped),
            for: .touchUpInside
        )

        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(donationRequirementsButtonPressed))
        descriptorView.infoStackView.addGestureRecognizer(tapGestureRecognizer)

        descriptionInputView.contentView.delegate = self
        titleInputView.contentView.textField.delegate = self
        keyboardStack.delegate = self
    }

    func configureData() {
        title = "Create Donation"
        descriptorView.titleLabel.text = "Complete with care"

        let attributedText = NSMutableAttributedString(string: "Find out more info about requirements by tapping here.")
        attributedText.addAttribute(
            .underlineStyle,
            value: NSUnderlineStyle.styleSingle.rawValue,
            range: NSRange(location: 41, length: 12)
        )

        descriptorView.subtitleStickyLabel.contentView.attributedText = attributedText

        descriptionInputView.contentView.text = CreateDonationViewController.descriptionPlaceholder
    }
    
    func configureStyling() {
        view.backgroundColor = UIColor.Pallete.White

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
        descriptionInputView.contentView.textColor = UIColor.Text.Placeholder
        descriptionInputView.contentView.backgroundColor = UIColor.Pallete.Gray
    }

    func configureLayout() {
        view.addSubview(pickUpAddressButton)

        configureOuterStackViewLayout()
        configurePickUpAddressButtonConstraints()

        descriptionInputView.contentView.autoSetDimension(.height, toSize: 64, relation: .greaterThanOrEqual)

        descriptorView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        descriptorView.subtitleStickyLabel.updateStickySide(to: .top)
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

    private func configurePickUpAddressButtonConstraints() {
        pickUpAddressButton.autoPinEdge(toSuperviewMargin: .leading)
        pickUpAddressButton.autoPinEdge(toSuperviewMargin: .trailing)
        pickUpAddressButton.autoPinEdge(toSuperviewMargin: .bottom)
    }
}
