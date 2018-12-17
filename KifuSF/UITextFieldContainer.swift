//
//  KFTextField.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 13/10/2018.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import UIKit

class UITextFieldContainer: UIView {
    //MARK: - Variables
    let textField = UITextField(forAutoLayout: ())

    //MARK: - Initializers
    convenience init(textContentType: UITextContentType, returnKeyType: UIReturnKeyType, isSecureTextEntry: Bool, placeholder: String) {
        self.init(textContentType: textContentType, returnKeyType: returnKeyType, placeholder: placeholder)

        textField.isSecureTextEntry = isSecureTextEntry
    }
    
    convenience init(textContentType: UITextContentType, returnKeyType: UIReturnKeyType, keyboardType: UIKeyboardType, placeholder: String) {
        self.init(textContentType: textContentType, returnKeyType: returnKeyType, placeholder: placeholder)

        textField.keyboardType = keyboardType
    }
    
    convenience init(textContentType: UITextContentType, returnKeyType: UIReturnKeyType, placeholder: String) {
        self.init(returnKeyType: returnKeyType, placeholder: placeholder)
        
        textField.textContentType = textContentType
    }

    convenience init(returnKeyType: UIReturnKeyType, placeholder: String) {
        self.init()

        textField.returnKeyType = returnKeyType
        textField.placeholder = placeholder
    }

    convenience init() {
        self.init(frame: CGRect.zero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        configureStyling()
        configureLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Methods
    func setTag(_ tag: Int) {
        self.tag = tag
        textField.tag = tag
    }
}

//MARK: - UIConfigurable
extension UITextFieldContainer: UIConfigurable {
    func configureStyling() {
        layer.cornerRadius = CALayer.kfCornerRadius
        backgroundColor = .kfGray
        textField.backgroundColor = .clear

        textField.clearButtonMode = .whileEditing
        textField.borderStyle = .none
        textField.enablesReturnKeyAutomatically = true

        textField.font = UIFont.preferredFont(forTextStyle: .title3)
        textField.adjustsFontForContentSizeCategory = true
    }

    func configureLayout() {
        directionalLayoutMargins = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
        addSubview(textField)
        textField.autoPinEdgesToSuperviewMargins()
    }
}
