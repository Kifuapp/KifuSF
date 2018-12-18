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
    let headlineLabel = UILabel()
    
    let infoStackView = UIStackView()
    
    let nameStackView = UIStackView()
    let nameTitleLabel = UIStickyView<UILabel>(stickySide: .top)
    let nameDescriptionLabel = UILabel()
    
    let phoneNumberStackView = UIStackView()
    let phoneNumberTitleLabel = UIStickyView<UILabel>(stickySide: .top)
    let phoneNumberDescriptionLabel = UILabel()
    
    let addressStackView = UIStackView()
    let addressTitleLabel = UIStickyView<UILabel>(stickySide: .top)
    let addressDescriptionLabel = UILabel()
    
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
        
        nameStackView.addArrangedSubview(nameTitleLabel)
        nameStackView.addArrangedSubview(nameDescriptionLabel)
        
        phoneNumberStackView.spacing = 4
        phoneNumberStackView.axis = .horizontal
        
        phoneNumberStackView.addArrangedSubview(phoneNumberTitleLabel)
        phoneNumberStackView.addArrangedSubview(phoneNumberDescriptionLabel)
        
        addressStackView.spacing = 4
        addressStackView.axis = .horizontal
        
        addressStackView.addArrangedSubview(addressTitleLabel)
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
        headlineLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        headlineLabel.numberOfLines = 0
        headlineLabel.textColor = UIColor.kfTitle
        headlineLabel.adjustsFontForContentSizeCategory = true
        
        nameTitleLabel.contentView.font = UIFont.preferredFont(forTextStyle: .body)
        nameTitleLabel.contentView.numberOfLines = 0
        nameTitleLabel.contentView.textColor = UIColor.kfTitle
        nameTitleLabel.contentView.adjustsFontForContentSizeCategory = true
        
        phoneNumberTitleLabel.contentView.font = UIFont.preferredFont(forTextStyle: .body)
        phoneNumberTitleLabel.contentView.numberOfLines = 0
        phoneNumberTitleLabel.contentView.textColor = UIColor.kfTitle
        phoneNumberTitleLabel.contentView.adjustsFontForContentSizeCategory = true
        
        addressTitleLabel.contentView.font = UIFont.preferredFont(forTextStyle: .body)
        addressTitleLabel.contentView.numberOfLines = 0
        addressTitleLabel.contentView.textColor = UIColor.kfTitle
        addressTitleLabel.contentView.adjustsFontForContentSizeCategory = true
        
        nameDescriptionLabel.font = UIFont.preferredFont(forTextStyle: .body)
        nameDescriptionLabel.numberOfLines = 0
        nameDescriptionLabel.textColor = UIColor.kfBody
        nameDescriptionLabel.adjustsFontForContentSizeCategory = true
        nameDescriptionLabel.textAlignment = .right
        
        phoneNumberDescriptionLabel.font = UIFont.preferredFont(forTextStyle: .body)
        phoneNumberDescriptionLabel.numberOfLines = 0
        phoneNumberDescriptionLabel.textColor = UIColor.kfBody
        phoneNumberDescriptionLabel.adjustsFontForContentSizeCategory = true
        phoneNumberDescriptionLabel.textAlignment = .right
        
        addressDescriptionLabel.font = UIFont.preferredFont(forTextStyle: .body)
        addressDescriptionLabel.numberOfLines = 0
        addressDescriptionLabel.textColor = UIColor.kfBody
        addressDescriptionLabel.adjustsFontForContentSizeCategory = true
        addressDescriptionLabel.textAlignment = .right
        
        headlineLabel.text = "Entity Info"
        nameTitleLabel.contentView.text = "Name"
        phoneNumberTitleLabel.contentView.text = "Phone Number"
        addressTitleLabel.contentView.text = "Address"
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
