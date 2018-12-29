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
    let motivationalLabel = UILabel(font: UIFont.preferredFont(forTextStyle: .title1),
                                    textColor: .kfBody)

    //MARK: - UIConfigurable
    override func configureLayout() {
        super.configureLayout()

        directionalLayoutMargins = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16)

        contentsStackView.addArrangedSubview(cosmosContainerView)
        contentsStackView.addArrangedSubview(motivationalLabel)

        cosmosContainerView.addSubview(cosmosView)
        cosmosView.autoPinEdge(toSuperviewEdge: .top)
        cosmosView.autoPinEdge(toSuperviewEdge: .bottom)
        cosmosView.autoAlignAxis(toSuperviewAxis: .vertical)
    }

    override func configureStyling() {
        super.configureStyling()

        layer.shadowOpacity = CALayer.kfShadowOpacity

        headlineLabel.textAlignment = .center

        motivationalLabel.textAlignment = .center
        motivationalLabel.text = "Horrific"

        cosmosContainerView.isUserInteractionEnabled = true

        cosmosView.settings.starSize = 30
    }
    

}
