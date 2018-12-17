//
//  KFVStatistics.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 08/09/2018.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import UIKit

class UIStatisticsView: UIView {
    //MARK: - Variables
    private let contentStackView = UIStackView(axis: .horizontal, alignment: .fill, spacing: KFPadding.ContentView, distribution: .fillEqually)
    
    private let deliveryStackView = UIStackView(axis: .horizontal, alignment: .fill, spacing: KFPadding.Body)
    private let deliveryIconView = UIIconView(image: .kfDeliveryIcon)
    private let deliveryCountLabel = UILabel(font: UIFont.preferredFont(forTextStyle: .subheadline), textColor: .kfSubtitle)
    
    private let donationStackView = UIStackView(axis: .horizontal, alignment: .fill, spacing: KFPadding.Body)
    private let donationIconView = UIIconView(image: .kfDonationIcon)
    private let donationCountLabel = UILabel(font: UIFont.preferredFont(forTextStyle: .subheadline), textColor: .kfSubtitle)

    //MARK: Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)

        configureLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Methods
    func reloadData(donations: Int, deliveries: Int) {
        donationCountLabel.text = "\(donations)"
        deliveryCountLabel.text = "\(deliveries)"
    }
}

//MARK: - UIConfigurable
extension UIStatisticsView: UIConfigurable {
    func configureLayout() {
        configureStackViewsLayout()

        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        contentStackView.autoPinEdgesToSuperviewEdges()
    }

    private func configureStackViewsLayout() {
        addSubview(contentStackView)

        deliveryStackView.addArrangedSubview(deliveryIconView)
        deliveryStackView.addArrangedSubview(deliveryCountLabel)

        donationStackView.addArrangedSubview(donationIconView)
        donationStackView.addArrangedSubview(donationCountLabel)

        contentStackView.addArrangedSubview(deliveryStackView)
        contentStackView.addArrangedSubview(donationStackView)
    }
}
