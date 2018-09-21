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
    var imageConstraints = [NSLayoutConstraint]()
    
    let infoStackView = UIStackView()
    
    let titleLabel = UILabel()
    let subtitleStickyLabel = KFVSticky<UILabel>()
    
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
        infoStackView.addArrangedSubview(subtitleStickyLabel)
        
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
        
        imageConstraints.append(imageView.autoSetDimension(.height, toSize: 112))
        imageConstraints.append(imageView.autoSetDimension(.width, toSize: 112))
        
        contentsStackView.autoPinEdge(toSuperviewEdge: .top, withInset: 8)
        contentsStackView.autoPinEdge(toSuperviewEdge: .leading, withInset: 8)
        contentsStackView.autoPinEdge(toSuperviewEdge: .trailing, withInset: 8)
        contentsStackView.autoPinEdge(toSuperviewEdge: .bottom, withInset: 8)
        
        titleLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        subtitleStickyLabel.setContentHuggingPriority(.defaultLow, for: .vertical)
    }
    
    func setUpStyling() {
        backgroundColor = UIColor.kfWhite
        layer.cornerRadius = CALayer.kfCornerRadius
        layer.setUpShadow()
        
        titleLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        titleLabel.numberOfLines = 0
        titleLabel.textColor = UIColor.kfTitle
        titleLabel.adjustsFontForContentSizeCategory = true
        
        subtitleStickyLabel.contentView.font = UIFont.preferredFont(forTextStyle: .subheadline)
        subtitleStickyLabel.contentView.numberOfLines = 0
        subtitleStickyLabel.contentView.textColor = UIColor.kfSubtitle
        subtitleStickyLabel.contentView.adjustsFontForContentSizeCategory = true
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        let isAccessibilityCategory = traitCollection.preferredContentSizeCategory.isAccessibilityCategory
        if isAccessibilityCategory != previousTraitCollection?.preferredContentSizeCategory.isAccessibilityCategory {
            topStackView.axis = .vertical
            //TODO: finish this
        }
    }
}
