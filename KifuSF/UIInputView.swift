//
//  UIInputView.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 16/12/2018.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import UIKit

class UIInputView: UIView {

    private let contentStackView = UIStackView(axis: .vertical, alignment: .fill,
                                               spacing: KFPadding.Body, distribution: .fill)
    let headerLabel = UILabel(font: UIFont.preferredFont(forTextStyle: .headline), textColor: .kfTitle)
    let textFieldContainer = UITextFieldContainer()

    override init(frame: CGRect) {
        super.init(frame: frame)

        configureLayout()
    }

    convenience init(title: String, placeholder: String, textContentType: UITextContentType, returnKeyType: UIReturnKeyType = .default) {
        self.init()

        headerLabel.text = title
        textFieldContainer.textField.textContentType = textContentType
        textFieldContainer.textField.returnKeyType = returnKeyType
        textFieldContainer.textField.placeholder = placeholder

        if textContentType == .password || textContentType == .newPassword {
            textFieldContainer.textField.isSecureTextEntry = true
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureLayout() {
        contentStackView.addArrangedSubview(headerLabel)
        contentStackView.addArrangedSubview(textFieldContainer)

        addSubview(contentStackView)

        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        contentStackView.autoPinEdgesToSuperviewEdges()
    }
}
