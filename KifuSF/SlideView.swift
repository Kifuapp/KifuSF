//
//  SlideView.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 29/12/2018.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import Foundation
import UIKit

class SlideView: UIView {
    // MARK: - Variables
    private let imageView = UIIconView(image: .kfBoxIcon)
    private let titleLabel = UILabel(font: UIFont.preferredFont(forTextStyle: .headline),
                                     textColor: UIColor.Text.Headline)
    private let descriptionLabel = UILabel(font: UIFont.preferredFont(forTextStyle: .body),
                                           textColor: UIColor.Text.SubHeadline)
    //MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)

        configureStyling()
        configureLayout()
    }

    convenience init(image: UIImage, title: String, description: String) {
        self.init()

        imageView.image = image
        titleLabel.text = title
        descriptionLabel.text = description
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UIConfigurable
extension SlideView: UIConfigurable {
    func configureStyling() {
        backgroundColor = UIColor.Pallete.White
        configureDescriptionLabelStyling()
    }

    func configureDescriptionLabelStyling() {
        descriptionLabel.textAlignment = .center
        descriptionLabel.alpha = 0.5
    }

    func configureLayout() {
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(descriptionLabel)

        configureImageViewConstraints()
        configureTitleLabelConstraints()
        configureDescriptionLabelConstraints()
    }

    func configureImageViewConstraints() {
        imageView.autoAlignAxis(toSuperviewAxis: .vertical)
        imageView.autoAlignAxis(.horizontal, toSameAxisOf: self, withOffset: -48)
        imageView.autoMatch(.width, to: .width, of: self, withMultiplier: 0.5)
        imageView.autoMatch(.height, to: .width, of: imageView)
    }

    func configureTitleLabelConstraints() {
        titleLabel
        titleLabel.autoAlignAxis(toSuperviewAxis: .vertical)

        let screenHeight = UIScreen.main.bounds.height
        titleLabel.autoPinEdge(.bottom, to: .top, of: descriptionLabel, withOffset: 8)
//        titleLabel.autoPinEdge(toSuperviewSafeArea: .bottom, withInset: screenHeight * 0.2)
    }

    func configureDescriptionLabelConstraints() {
        let screenHeight = UIScreen.main.bounds.height
//        descriptionLabel.autoPinEdge(.top, to: .bottom, of: titleLabel, withOffset: 8)
        descriptionLabel.autoPinEdge(toSuperviewSafeArea: .bottom, withInset: screenHeight * 0.1)
        descriptionLabel.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 72)
        descriptionLabel.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 72)
    }
}
