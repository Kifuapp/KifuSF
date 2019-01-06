//
//  KFVEntityInfo.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 28/09/2018.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import UIKit

class KFVEntityInfo: UIView {

    let contentsStackView = UIStackView()
    let headlineLabel = UILabel(font: UIFont.preferredFont(forTextStyle: .headline),
                                textColor: UIColor.Text.Headline)
    
    let infoStackView = UIStackView()
    
    let nameStackView = UIStackView()
    let nameTitleStickyLabel = UIStickyView<UILabel>(stickySide: .top)
    let nameDescriptionLabel = UILabel(font: UIFont.preferredFont(forTextStyle: .body),
                                       textColor: UIColor.Text.Body)
    
    let phoneNumberStackView = UIStackView()
    let phoneNumberTitleStickyLabel = UIStickyView<UILabel>(stickySide: .top)
    let phoneNumberDescriptionLabel = UILabel(font: UIFont.preferredFont(forTextStyle: .body),
                                              textColor: UIColor.Text.Body)
    
    let addressStackView = UIStackView()
    let addressTitleStickyLabel = UIStickyView<UILabel>(stickySide: .top)
    let addressDescriptionLabel = UILabel(font: UIFont.preferredFont(forTextStyle: .body),
                                          textColor: UIColor.Text.Body)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(contentsStackView)
        
        setUpStyling()
        setUpLayoutConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpLayoutConstraints() {
        nameStackView.spacing = 4
        nameStackView.axis = .horizontal
        
        nameStackView.addArrangedSubview(nameTitleStickyLabel)
        nameStackView.addArrangedSubview(nameDescriptionLabel)
        
        phoneNumberStackView.spacing = 4
        phoneNumberStackView.axis = .horizontal
        
        phoneNumberStackView.addArrangedSubview(phoneNumberTitleStickyLabel)
        phoneNumberStackView.addArrangedSubview(phoneNumberDescriptionLabel)
        
        addressStackView.spacing = 4
        addressStackView.axis = .horizontal
        
        addressStackView.addArrangedSubview(addressTitleStickyLabel)
        addressStackView.addArrangedSubview(addressDescriptionLabel)
        
        infoStackView.axis = .vertical
        infoStackView.spacing = 8
        
        infoStackView.addArrangedSubview(nameStackView)
        infoStackView.addArrangedSubview(phoneNumberStackView)
        infoStackView.addArrangedSubview(addressStackView)
        
        contentsStackView.axis = .vertical
        contentsStackView.spacing = 16
        
        contentsStackView.addArrangedSubview(headlineLabel)
        contentsStackView.addArrangedSubview(infoStackView)
        
        translatesAutoresizingMaskIntoConstraints = false
        contentsStackView.translatesAutoresizingMaskIntoConstraints = false
        
        contentsStackView.autoPinEdge(toSuperviewEdge: .top, withInset: 8)
        contentsStackView.autoPinEdge(toSuperviewEdge: .leading, withInset: 8)
        contentsStackView.autoPinEdge(toSuperviewEdge: .trailing, withInset: 8)
        contentsStackView.autoPinEdge(toSuperviewEdge: .bottom, withInset: 8)
    }
    
    func setUpStyling() {
        nameTitleStickyLabel.contentView.font = UIFont.preferredFont(forTextStyle: .body)
        nameTitleStickyLabel.contentView.textColor = UIColor.Text.Headline
        nameTitleStickyLabel.contentView.activateDynamicType()
        
        phoneNumberTitleStickyLabel.contentView.font = UIFont.preferredFont(forTextStyle: .body)
        phoneNumberTitleStickyLabel.contentView.textColor = UIColor.Text.Headline
        phoneNumberTitleStickyLabel.contentView.activateDynamicType()
        
        addressTitleStickyLabel.contentView.font = UIFont.preferredFont(forTextStyle: .body)
        addressTitleStickyLabel.contentView.textColor = UIColor.Text.Headline
        addressTitleStickyLabel.contentView.activateDynamicType()

        nameDescriptionLabel.textAlignment = .right
        phoneNumberDescriptionLabel.textAlignment = .right
        addressDescriptionLabel.textAlignment = .right
        
        headlineLabel.text = "Entity Info"
        nameTitleStickyLabel.contentView.text = "Name"
        phoneNumberTitleStickyLabel.contentView.text = "Phone Number"
        addressTitleStickyLabel.contentView.text = "Address"
    }
    
    func reloadData(for data: KFMEntityInfo) {
        nameDescriptionLabel.text = data.name
        phoneNumberDescriptionLabel.text = data.phoneNumber
        addressDescriptionLabel.text = data.address
        headlineLabel.text = "\(data.entityType.rawValue.capitalized) Info"
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        let isAccessibilityCategory = traitCollection.preferredContentSizeCategory.isAccessibilityCategory
        if isAccessibilityCategory != previousTraitCollection?.preferredContentSizeCategory.isAccessibilityCategory {
            nameStackView.axis = .vertical
            phoneNumberStackView.axis = .vertical
            addressStackView.axis = .vertical
            //TODO: finish this
        }
    }
}
