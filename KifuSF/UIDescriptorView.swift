//
//  KFVDescriptor.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 07/09/2018.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import UIKit
import PureLayout

class UIDescriptorView: UIView, UIConfigurable {
    //MARK: - Variables
    let contentsStackView = UIStackView(axis: .vertical, alignment: .fill,
                                        spacing: KFPadding.StackView, distribution: .fill)
    let topStackView = UIStackView(axis: .horizontal, alignment: .fill,
                                   spacing: KFPadding.StackView)

    let imageView = UIImageView()
    var defaultImageViewSize = UIImageView.Size.small

    let infoStackView = UIStackView(axis: .vertical, alignment: .leading, distribution: .fill)

    let titleLabel = UILabel(font: UIFont.preferredFont(forTextStyle: .headline), textColor: .kfTitle)
    let subtitleStickyLabel = KFVSticky<UILabel>()

    //MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)

        configureStyling()
        configureLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Lifecycle
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        let isAccessibilityCategory = traitCollection.preferredContentSizeCategory.isAccessibilityCategory

        topStackView.axis = (isAccessibilityCategory) ? .vertical : .horizontal
        imageView.constraints.forEach { (constraint) in
            guard let identifier = constraint.identifier,
                let size = UIImageView.Size(rawValue: identifier) else {

                return
            }

            let priority: Float
            switch size {
            case .big:
                priority = (isAccessibilityCategory) ? 751 : 249
            case .medium where defaultImageViewSize == .medium:
                priority = (isAccessibilityCategory) ? 249 : 751
            case .small where defaultImageViewSize == .small:
                constraint.priority = UILayoutPriority(rawValue: 249)
                priority = (isAccessibilityCategory) ? 249 : 751
            default:
                priority = 249
            }

            constraint.priority = UILayoutPriority(rawValue: priority)
        }
    }

    //MARK: - UIConfigurable
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

    func configureLayout() {
        directionalLayoutMargins = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)

        addSubview(contentsStackView)

        configureStackViewsLayout()
        configureContentsStackViewConstraints()
        configureImageViewConstraints()

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

        contentsStackView.autoPinEdge(toSuperviewMargin: .top)
        contentsStackView.autoPinEdge(toSuperviewMargin: .leading)
        contentsStackView.autoPinEdge(toSuperviewMargin: .trailing)
        contentsStackView.autoPinEdge(toSuperviewMargin: .bottom)
    }

    private func configureImageViewConstraints() {
        imageView.autoSetDimension(.height, toSize: UIImageView.Size.small.get())
            .autoIdentify(UIImageView.Size.small.rawValue).priority = UILayoutPriority(rawValue: 751)
        imageView.autoSetDimension(.width, toSize: UIImageView.Size.small.get())
            .autoIdentify(UIImageView.Size.small.rawValue).priority = UILayoutPriority(rawValue: 751)

        imageView.autoSetDimension(.height, toSize: UIImageView.Size.medium.get())
            .autoIdentify(UIImageView.Size.medium.rawValue).priority = UILayoutPriority(rawValue: 249)
        imageView.autoSetDimension(.width, toSize: UIImageView.Size.medium.get())
            .autoIdentify(UIImageView.Size.medium.rawValue).priority = UILayoutPriority(rawValue: 249)

        imageView.autoSetDimension(.height, toSize: UIImageView.Size.big.get())
            .autoIdentify(UIImageView.Size.big.rawValue).priority = UILayoutPriority(rawValue: 249)
        imageView.autoSetDimension(.width, toSize: UIImageView.Size.big.get())
            .autoIdentify(UIImageView.Size.big.rawValue).priority = UILayoutPriority(rawValue: 249)
    }
}
