//
//  KFVStatistics.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 08/09/2018.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import UIKit

class KFVStatistics: UIView, UIConfigurable {
    let contentStackView = UIStackView(axis: .horizontal, alignment: .fill, spacing: KFPadding.ContentView, distribution: .fillEqually)
    
    let deliveryStackView = UIStackView(axis: .horizontal, alignment: .fill, spacing: KFPadding.Body)
    let deliveryIconView = KFVIcon(image: .kfDeliveryIcon)
    let deliveryCountLabel = UILabel(font: UIFont.preferredFont(forTextStyle: .subheadline), textColor: .kfSubtitle)
    
    let donationStackView = UIStackView(axis: .horizontal, alignment: .fill, spacing: KFPadding.Body)
    let donationIconView = KFVIcon(image: .kfDonationIcon)
    let donationCountLabel = UILabel(font: UIFont.preferredFont(forTextStyle: .subheadline), textColor: .kfSubtitle)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(contentStackView)
        configureLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureLayout() {
        configureStackViewsLayout()
        
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        contentStackView.autoPinEdgesToSuperviewEdges()
    }
    
    private func configureStackViewsLayout() {
        deliveryStackView.addArrangedSubview(deliveryIconView)
        deliveryStackView.addArrangedSubview(deliveryCountLabel)
        
        donationStackView.addArrangedSubview(donationIconView)
        donationStackView.addArrangedSubview(donationCountLabel)
        
        contentStackView.addArrangedSubview(deliveryStackView)
        contentStackView.addArrangedSubview(donationStackView)
    }
}
