//
//  KFVDescriptor.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 07/09/2018.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import UIKit
import PureLayout

class KFVDescriptor: UIView {
    
    let contentsStackView = UIStackView()
    let topStackView = UIStackView()
    
    let imageView = KFVImage()
    
    let infoStackView = UIStackView()
    
    let titleLabel = UILabel()
    let subtitleLabel = KFVSticky<UILabel>(stickySide: .top)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(contentsStackView)
        
        setUpStyling()
        setupLayoutConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayoutConstraints() {
        layer.masksToBounds = false
        
        translatesAutoresizingMaskIntoConstraints = false
        contentsStackView.translatesAutoresizingMaskIntoConstraints = false
        
        infoStackView.axis = .vertical
        infoStackView.alignment = .leading
        infoStackView.distribution = .fill
        infoStackView.spacing = 0
        
        infoStackView.addArrangedSubview(titleLabel)
        infoStackView.addArrangedSubview(subtitleLabel)
        
        topStackView.axis = .horizontal
        topStackView.alignment = .fill
        topStackView.distribution = .fill
        topStackView.spacing = 16
        
        topStackView.addArrangedSubview(imageView)
        topStackView.addArrangedSubview(infoStackView)
        
        contentsStackView.axis = .vertical
        contentsStackView.alignment = .fill
        contentsStackView.distribution = .fill
        contentsStackView.spacing = 16
        
        contentsStackView.addArrangedSubview(topStackView)
        
//        imageView.autoMatch(.height, to: .width, of: imageView)
        imageView.autoSetDimension(.height, toSize: 112)
        imageView.autoSetDimension(.width, toSize: 112)
        
        contentsStackView.autoPinEdge(toSuperviewEdge: .top, withInset: 8)
        contentsStackView.autoPinEdge(toSuperviewEdge: .leading, withInset: 8)
        contentsStackView.autoPinEdge(toSuperviewEdge: .trailing, withInset: 8)
        contentsStackView.autoPinEdge(toSuperviewEdge: .bottom, withInset: 8)
        
        titleLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        subtitleLabel.setContentHuggingPriority(.defaultLow, for: .vertical)
    }
    
    func setUpStyling() {
        backgroundColor = UIColor.kfWhite
        layer.cornerRadius = CALayer.kfCornerRadius
        layer.setUpShadow()
        
        titleLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        titleLabel.numberOfLines = 0
        titleLabel.textColor = UIColor.kfTitle
        titleLabel.adjustsFontForContentSizeCategory = true
        
        subtitleLabel.contentView.font = UIFont.preferredFont(forTextStyle: .subheadline)
        subtitleLabel.contentView.numberOfLines = 0
        subtitleLabel.contentView.textColor = UIColor.kfBody
        subtitleLabel.contentView.adjustsFontForContentSizeCategory = true
        
        //TODO: remove this
        subtitleLabel.contentView.text = "Reputation 78%"
        titleLabel.text = "@Torcky"
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        let isAccessibilityCategory = traitCollection.preferredContentSizeCategory.isAccessibilityCategory
        if isAccessibilityCategory != previousTraitCollection?.preferredContentSizeCategory.isAccessibilityCategory {
            topStackView.axis = .vertical
            //TODO: finish this
        }
    }
}
