//
//  KFTextField.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 13/10/2018.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import UIKit

class KFTextFieldContainer: UIView, UIConfigurable {
    
    let textField = UITextField()
    
    convenience init(textContentType: UITextContentType, returnKeyType: UIReturnKeyType, isSecureTextEntry: Bool ,placeholder: String) {
        self.init(textContentType: textContentType, returnKeyType: returnKeyType, placeholder: placeholder)
        
        textField.isSecureTextEntry = isSecureTextEntry
    }
    
    convenience init(textContentType: UITextContentType, returnKeyType: UIReturnKeyType, keyboardType: UIKeyboardType ,placeholder: String) {
        self.init(textContentType: textContentType, returnKeyType: returnKeyType, placeholder: placeholder)
        
        textField.keyboardType = keyboardType
    }
    
    convenience init(textContentType: UITextContentType, returnKeyType: UIReturnKeyType, placeholder: String) {
        self.init()
        
        textField.textContentType = textContentType
        textField.returnKeyType = returnKeyType
        textField.placeholder = placeholder
    }

    convenience init() {
        self.init(frame: CGRect.zero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(textField)
        
        configureStyling()
        configureLayoutConstraints()
    }
    
    func setTag(_ tag: Int) {
        self.tag = tag
        textField.tag = tag
    }
    
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
    
    func configureLayoutConstraints() {
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        textField.autoPinEdge(toSuperviewEdge: .top, withInset: KFPadding.ContentView)
        textField.autoPinEdge(toSuperviewEdge: .leading, withInset: KFPadding.ContentView)
        textField.autoPinEdge(toSuperviewEdge: .trailing, withInset: KFPadding.ContentView)
        textField.autoPinEdge(toSuperviewEdge: .bottom, withInset: KFPadding.ContentView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
