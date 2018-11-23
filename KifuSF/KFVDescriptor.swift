//
//  KFVDescriptor.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 07/09/2018.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import UIKit
import PureLayout

class KFVDescriptor: UIView, UIConfigurable {
    
    let contentsStackView = UIStackView(axis: .vertical, alignment: .fill,
                                        spacing: KFPadding.StackView, distribution: .fill)
    let topStackView = UIStackView(axis: .horizontal, alignment: .fill,
                                   spacing: KFPadding.StackView, distribution: .fill)

    let imageView = KFVImage()
    var imageConstraints = [NSLayoutConstraint]()

    let infoStackView = UIStackView(axis: .vertical, alignment: .leading, distribution: .fill)

    let titleLabel = KFLabel(font: UIFont.preferredFont(forTextStyle: .headline), textColor: .kfTitle)
    let subtitleStickyLabel = KFVSticky<KFLabel>()

    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(contentsStackView)

        configureStyling()
        configureLayoutConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        let isAccessibilityCategory = traitCollection.preferredContentSizeCategory.isAccessibilityCategory
        if isAccessibilityCategory {
            topStackView.axis = .vertical
            //TODO: finish this
        } else {
            topStackView.axis = .horizontal
        }
    }

    func configureStyling() {
        configureDescriptorStyling()
        configureSubtitleStickyLabelStyling()
        
        imageView.makeItKifuStyle()
    }

    private func configureSubtitleStickyLabelStyling() {
        subtitleStickyLabel.contentView.font = UIFont.preferredFont(forTextStyle: .subheadline)
        subtitleStickyLabel.contentView.textColor = UIColor.kfSubtitle
        subtitleStickyLabel.contentView.makeItKifuStyle()
    }
    private func configureDescriptorStyling() {
        backgroundColor = UIColor.kfSuperWhite
        layer.masksToBounds = false
        layer.cornerRadius = CALayer.kfCornerRadius
        layer.setUpShadow()
    }

    func configureLayoutConstraints() {
        configureStackViewsLayout()
        configureContentsStackViewConstraints()

        imageConstraints.append(imageView.autoSetDimension(.height, toSize: KFPadding.SmallPictureLength))
        imageConstraints.append(imageView.autoSetDimension(.width, toSize: KFPadding.SmallPictureLength))

        titleLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        subtitleStickyLabel.setContentHuggingPriority(.defaultLow, for: .vertical)
    }

    private func configureStackViewsLayout() {
        infoStackView.addArrangedSubview(titleLabel)
        infoStackView.addArrangedSubview(subtitleStickyLabel)

        topStackView.addArrangedSubview(imageView)
        topStackView.addArrangedSubview(infoStackView)

        contentsStackView.addArrangedSubview(topStackView)
    }

    private func configureContentsStackViewConstraints() {
        contentsStackView.translatesAutoresizingMaskIntoConstraints = false
        contentsStackView.autoPinEdge(toSuperviewEdge: .top, withInset: KFPadding.ContentView)
        contentsStackView.autoPinEdge(toSuperviewEdge: .leading, withInset: KFPadding.ContentView)
        contentsStackView.autoPinEdge(toSuperviewEdge: .trailing, withInset: KFPadding.ContentView)
        contentsStackView.autoPinEdge(toSuperviewEdge: .bottom, withInset: KFPadding.ContentView)
    }
}
