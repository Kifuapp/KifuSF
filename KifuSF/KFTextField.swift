//
//  KFTextField.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 13/10/2018.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import UIKit

class KFTextField: UIView, Configurable {
    
    let contentView = UITextField()
    
    convenience init(textContentType: UITextContentType, returnKeyType: UIReturnKeyType, isSecureTextEntry: Bool ,placeholder: String) {
        self.init(textContentType: textContentType, returnKeyType: returnKeyType, placeholder: placeholder)
        
        contentView.isSecureTextEntry = isSecureTextEntry
    }
    
    convenience init(textContentType: UITextContentType, returnKeyType: UIReturnKeyType, placeholder: String) {
        self.init()
        
        contentView.textContentType = textContentType
        contentView.returnKeyType = returnKeyType
        contentView.placeholder = placeholder
    }

    convenience init() {
        self.init(frame: CGRect.zero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(contentView)
        
        configureStyling()
        configureLayoutConstraints()
    }
    
    func setTag(_ tag: Int) {
        self.tag = tag
        contentView.tag = tag
    }
    
    func configureStyling() {
        layer.cornerRadius = CALayer.kfCornerRadius
        backgroundColor = .kfGray
        contentView.backgroundColor = .clear
        
        contentView.clearButtonMode = .whileEditing
        contentView.borderStyle = .none
        contentView.enablesReturnKeyAutomatically = true
        
        contentView.font = UIFont.preferredFont(forTextStyle: .title3)
        contentView.adjustsFontForContentSizeCategory = true
    }
    
    func configureLayoutConstraints() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.autoPinEdge(toSuperviewEdge: .top, withInset: KFPadding.ContentView)
        contentView.autoPinEdge(toSuperviewEdge: .leading, withInset: KFPadding.ContentView)
        contentView.autoPinEdge(toSuperviewEdge: .trailing, withInset: KFPadding.ContentView)
        contentView.autoPinEdge(toSuperviewEdge: .bottom, withInset: KFPadding.ContentView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
