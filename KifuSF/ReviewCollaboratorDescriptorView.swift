//
//  CollaboratorReviewDescriptorView.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 29/12/2018.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import UIKit
import Cosmos

class ReviewCollaboratorDescriptorView: CollaboratorDescriptorView {
    //MARK: - Variables
    let cosmosContainerView = UIView()
    let cosmosView = CosmosView(forAutoLayout: ())
    let motivationalLabel = UILabel(font: UIFontMetrics(forTextStyle: .title2)
                                    .scaledFont(for: UIFont.italicSystemFont(ofSize: 22)),
                                    textColor: .kfBody)

    static let motivationalMessages = ["Rate your friend",
                                       "\"Horrific\"",
                                       "\"Awful\"",
                                       "\"Suboptimal\"",
                                       "\"Good\"",
                                       "\"Great!\""]

    //MARK: - UIConfigurable
    override func configureLayout() {
        super.configureLayout()
        directionalLayoutMargins = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16)

        contentsStackView.addArrangedSubview(cosmosContainerView)
        cosmosContainerView.addSubview(cosmosView)
        cosmosContainerView.addSubview(motivationalLabel)

        cosmosView.autoPinEdge(toSuperviewEdge: .top)
        cosmosView.autoAlignAxis(toSuperviewAxis: .vertical)

        configureMotivationalLabelConstraints()
    }

    func configureMotivationalLabelConstraints() {
        motivationalLabel.translatesAutoresizingMaskIntoConstraints = false

        motivationalLabel.autoPinEdge(.top, to: .bottom, of: cosmosView, withOffset: 8)
        motivationalLabel.autoPinEdge(toSuperviewMargin: .leading)
        motivationalLabel.autoPinEdge(toSuperviewMargin: .trailing)
        motivationalLabel.autoPinEdge(toSuperviewMargin: .bottom)
    }

    override func configureStyling() {
        super.configureStyling()

        layer.shadowOpacity = CALayer.kfShadowOpacity
        headlineLabel.textAlignment = .center

        configureMotivationalLabelStyling()
        configureCosmosViewStyling()
    }

    func configureMotivationalLabelStyling() {
        motivationalLabel.textAlignment = .center
    }

    func configureCosmosViewStyling() {
        cosmosContainerView.isUserInteractionEnabled = true
        cosmosView.settings.starSize = 32
        cosmosView.rating = 0

        cosmosView.didTouchCosmos = { [unowned self] rating in
            self.motivationalLabel.text = ReviewCollaboratorDescriptorView.motivationalMessages[Int(rating)]
        }
    }
}
