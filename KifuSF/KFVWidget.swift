//
//  KFWidgetView.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 28/08/2018.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import UIKit

final class KFVWidget: UIView, Configurable {
    
    enum TouchedViewType {
        case donation
        case delivery
    }
    
    public struct KFMWidgetInfo: KFPWidgetInfo {
        let title: String
        let subtitle: String
    }
    
    let containerStackView = UIStackView(axis: .vertical, alignment: .fill, distribution: .fillEqually)
    
    let backgroundsStackView = UIStackView(axis: .vertical, alignment: .fill, distribution: .fillEqually)
    let deliveryBackgroundView = UIView()
    let donationBackgroundView = UIView()

    let deliveryStackView = UIStackView(axis: .vertical, alignment: .fill, distribution: .fill)
    let deliveryContentsStackView = UIStackView(axis: .horizontal, alignment: .center, spacing: 16, distribution: .fill)
    
    let deliveryLeftEmptyView = UIView()
    let deliveryIconView = KFVIcon(image: .kfDeliveryIcon)
    
    let deliveryTextBodyStackView = UIStackView(axis: .vertical, alignment: .fill, distribution: .fillEqually)
    let deliveryTitleLabel = KFLabel(font: UIFont.preferredFont(forTextStyle: .headline), textColor: .kfTitle)
    let deliverySubtitleLabel = KFLabel(font: UIFont.preferredFont(forTextStyle: .subheadline), textColor: .kfSubtitle)
    
    let deliveryDisclosureImageView = KFVIcon(image: .kfDisclosureIcon)
    let deliveryRightEmptyView = UIView()
    let deliverySpacer = UIView()
    
    let donationStackView = UIStackView(axis: .vertical, alignment: .fill, distribution: .fill)
    let donationContentsStackView = UIStackView(axis: .horizontal, alignment: .center, spacing: 16, distribution: .fill)
    
    let donationLeftEmptyView = UIView()
    let donationIconView = KFVIcon(image: .kfDonationIcon)
    
    let donationTextBodyStackView = UIStackView(axis: .vertical, alignment: .fill, distribution: .fillEqually)
    let donationTitleLabel = KFLabel(font: UIFont.preferredFont(forTextStyle: .headline), textColor: .kfTitle)
    let donationSubtitleLabel = KFLabel(font: UIFont.preferredFont(forTextStyle: .subheadline), textColor: .kfSubtitle)
    
    let donationDisclosureImageView = KFVIcon(image: .kfDisclosureIcon)
    let donationRightEmptyView = UIView()
    let donationSpacer = UIView()
    
    weak var dataSource: KFPWidgetDataSource?
    weak var delegate: KFPWidgetDelegate?
    
    private var touchedViewType: TouchedViewType? {
        didSet {
            switch touchedViewType {
            case .donation?:
                donationBackgroundView.backgroundColor = UIColor.kfSuperWhite.darker(by: 5)
                deliveryBackgroundView.backgroundColor = UIColor.kfSuperWhite
            case .delivery?:
                donationBackgroundView.backgroundColor = UIColor.kfSuperWhite
                deliveryBackgroundView.backgroundColor = UIColor.kfSuperWhite.darker(by: 5)
            case .none:
                donationBackgroundView.backgroundColor = UIColor.kfSuperWhite
                deliveryBackgroundView.backgroundColor = UIColor.kfSuperWhite
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureStyling()
        configureLayoutConstraints()
        
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(updateWidgetView))
        longPress.minimumPressDuration = 0
        longPress.allowableMovement = 10
        
        containerStackView.addGestureRecognizer(longPress)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        let isAccessibilityCategory = traitCollection.preferredContentSizeCategory.isAccessibilityCategory
        if isAccessibilityCategory {
            deliverySubtitleLabel.isHidden = true
            donationSubtitleLabel.isHidden = true
        } else {
            deliverySubtitleLabel.isHidden = false
            donationSubtitleLabel.isHidden = false
        }
        
        layoutIfNeeded()
        delegate?.widgetView(self, heightDidChange: frame.height)
    }
    
    func configureLayoutConstraints() {
        configureDeliveryStackViewLayout()
        configureDonationStackViewLayout()
        configureOuterStackViewsLayout()
        
        addSubview(backgroundsStackView)
        addSubview(containerStackView)
        
        deliveryTextBodyStackView.setContentHuggingPriority(.init(250), for: .horizontal)
        donationTextBodyStackView.setContentHuggingPriority(.init(250), for: .horizontal)
        
        configureEmptyViewsConstraints()
        configureSpacersConstraints()
        configureIconsConstraints()
        configureTextPadding()
        configureStackViewsPadding()
    }
    
    private func configureEmptyViewsConstraints() {
        configureDeliveryEmptyViewConstraints()
        configureDonationEmptyViewConstraints()
    }
    
    private func configureDeliveryEmptyViewConstraints() {
        deliveryLeftEmptyView.translatesAutoresizingMaskIntoConstraints = false
        deliveryRightEmptyView.translatesAutoresizingMaskIntoConstraints = false
        
        deliveryLeftEmptyView.autoSetDimension(.width, toSize: 0)
        deliveryRightEmptyView.autoSetDimension(.width, toSize: 0)
    }
    
    private func configureDonationEmptyViewConstraints() {
        donationLeftEmptyView.translatesAutoresizingMaskIntoConstraints = false
        donationRightEmptyView.translatesAutoresizingMaskIntoConstraints = false
        
        donationLeftEmptyView.autoSetDimension(.width, toSize: 0)
        donationRightEmptyView.autoSetDimension(.width, toSize: 0)
    }
    
    private func configureSpacersConstraints() {
        deliverySpacer.translatesAutoresizingMaskIntoConstraints = false
        donationSpacer.translatesAutoresizingMaskIntoConstraints = false
        
        deliverySpacer.autoSetDimension(.height, toSize: 0.5)
        donationSpacer.autoSetDimension(.height, toSize: 0.5)
    }
    
    private func configureIconsConstraints() {
        deliveryIconView.translatesAutoresizingMaskIntoConstraints = false
        deliveryDisclosureImageView.translatesAutoresizingMaskIntoConstraints = false
        
        donationIconView.translatesAutoresizingMaskIntoConstraints = false
        donationDisclosureImageView.translatesAutoresizingMaskIntoConstraints = false
        
        configureAspectRatioForIcons()
        configureSameSizeForIcons()
    }
    
    private func configureAspectRatioForIcons() {
        //aspect ratio 1:1 for all icons
        deliveryDisclosureImageView.autoMatch(.height, to: .width, of: deliveryDisclosureImageView)
        donationDisclosureImageView.autoMatch(.height, to: .width, of: donationDisclosureImageView)
        
        deliveryIconView.autoMatch(.height, to: .width, of: deliveryIconView)
        donationIconView.autoMatch(.height, to: .width, of: donationIconView)
    }
    
    private func configureSameSizeForIcons() {
        //makes the width and height of all the icons to be bonded, therefore making all icons to have the same size
        deliveryDisclosureImageView.autoMatch(.height, to: .height, of: deliveryIconView, withMultiplier: 0.75)
        donationDisclosureImageView.autoMatch(.height, to: .height, of: donationIconView, withMultiplier: 0.75)
        donationIconView.autoMatch(.height, to: .height, of: deliveryIconView)
    }
    
    private func configureTextPadding() {
        //makes the textBodyStackViews to be centered by adding some padding
        deliveryTextBodyStackView.translatesAutoresizingMaskIntoConstraints = false
        donationTextBodyStackView.translatesAutoresizingMaskIntoConstraints = false
        
        deliveryTextBodyStackView.autoPinEdge(toSuperviewEdge: .top, withInset: KFPadding.ContentView)
        deliveryTextBodyStackView.autoPinEdge(toSuperviewEdge: .bottom, withInset: KFPadding.ContentView)
        
        donationTextBodyStackView.autoPinEdge(toSuperviewEdge: .top, withInset: KFPadding.ContentView)
        donationTextBodyStackView.autoPinEdge(toSuperviewEdge: .bottom, withInset: KFPadding.ContentView)
    }
    
    private func configureStackViewsPadding() {
        //pins the outer stackviews to the edge
        containerStackView.translatesAutoresizingMaskIntoConstraints = false
        backgroundsStackView.translatesAutoresizingMaskIntoConstraints = false
        
        containerStackView.autoPinEdgesToSuperviewEdges()
        backgroundsStackView.autoPinEdgesToSuperviewEdges()
    }
    
    private func configureOuterStackViewsLayout() {
        containerStackView.addArrangedSubview(deliveryStackView)
        containerStackView.addArrangedSubview(donationStackView)
        
        backgroundsStackView.addArrangedSubview(deliveryBackgroundView)
        backgroundsStackView.addArrangedSubview(donationBackgroundView)
    }
    
    private func configureDeliveryStackViewLayout() {
        deliveryTextBodyStackView.addArrangedSubview(deliveryTitleLabel)
        deliveryTextBodyStackView.addArrangedSubview(deliverySubtitleLabel)
        
        configureContentDeliveryStackViewLayout()
        
        deliveryStackView.addArrangedSubview(deliveryContentsStackView)
        deliveryStackView.addArrangedSubview(deliverySpacer)
    }
    
    private func configureContentDeliveryStackViewLayout() {
        deliveryContentsStackView.addArrangedSubview(deliveryLeftEmptyView)
        deliveryContentsStackView.addArrangedSubview(deliveryIconView)
        deliveryContentsStackView.addArrangedSubview(deliveryTextBodyStackView)
        deliveryContentsStackView.addArrangedSubview(deliveryDisclosureImageView)
        deliveryContentsStackView.addArrangedSubview(deliveryRightEmptyView)
    }
    
    private func configureDonationStackViewLayout() {
        donationTextBodyStackView.addArrangedSubview(donationTitleLabel)
        donationTextBodyStackView.addArrangedSubview(donationSubtitleLabel)
        
        configureContentDonationStackViewLayout()
        
        donationStackView.addArrangedSubview(donationContentsStackView)
        donationStackView.addArrangedSubview(donationSpacer)
    }
    
    private func configureContentDonationStackViewLayout() {
        donationContentsStackView.addArrangedSubview(donationLeftEmptyView)
        donationContentsStackView.addArrangedSubview(donationIconView)
        donationContentsStackView.addArrangedSubview(donationTextBodyStackView)
        donationContentsStackView.addArrangedSubview(donationDisclosureImageView)
        donationContentsStackView.addArrangedSubview(donationRightEmptyView)
    }
    
    func configureStyling() {
        //TODO: fix the color literal, but in the future no rush here
        deliverySpacer.backgroundColor = #colorLiteral(red: 0.6941176471, green: 0.6941176471, blue: 0.6941176471, alpha: 1)
        donationSpacer.backgroundColor = #colorLiteral(red: 0.6941176471, green: 0.6941176471, blue: 0.6941176471, alpha: 1)
        
        deliveryDisclosureImageView.tintColor = .kfPrimary
        donationDisclosureImageView.tintColor = .kfPrimary
        
        touchedViewType = nil
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc private func updateWidgetView(_ sender: UILongPressGestureRecognizer) {
        let touchLocation = sender.location(in: containerStackView)
        
        switch sender.state {
        case .began, .changed:
            updateState(for: touchLocation)

        case .ended:
            updateState(for: touchLocation)
            //TODO: check if it's inside
            if let type = touchedViewType, containerStackView.frame.contains(touchLocation), touchLocation.x != 0 {
                delegate?.widgetView(self, didSelectCellForType: type)
            }
            touchedViewType = nil
            
        default:
            break
        }
    }
    
    private func updateState(for location: CGPoint) {
        if deliveryStackView.frame.contains(location)  {
            touchedViewType = .delivery
        } else if donationStackView.frame.contains(location) {
            touchedViewType = .donation
        } else {
            touchedViewType = nil
        }
    }
    
    private func updateInfo() {
        if let deliveryInfo = dataSource?.widgetView(self, cellInfoForType: .delivery) {
            deliveryStackView.isHidden = false
            deliveryBackgroundView.isHidden = false
            
            deliveryTitleLabel.text = "Delivery - \(deliveryInfo.title)"
            deliverySubtitleLabel.text = deliveryInfo.subtitle
        } else {
            deliveryStackView.isHidden = true
            deliveryBackgroundView.isHidden = true
        }
        
        if let donationInfo = dataSource?.widgetView(self, cellInfoForType: .donation) {
            donationStackView.isHidden = false
            donationBackgroundView.isHidden = false
            
            donationTitleLabel.text = "Donation - \(donationInfo.title)"
            donationSubtitleLabel.text = donationInfo.subtitle
        } else {
            donationStackView.isHidden = true
            donationBackgroundView.isHidden = true
        }
        
        self.layoutIfNeeded()
        delegate?.widgetView(self, heightDidChange: frame.height)
    }
    
    func reloadData() {
        updateInfo()
    }

}

//MARK: KFPWidgetDataSource
protocol KFPWidgetDataSource: class {
    func widgetView(_ widgetView: KFVWidget, cellInfoForType type: KFVWidget.TouchedViewType) -> KFPWidgetInfo?
}

//MARK: KFPWidgetDelegate
protocol KFPWidgetDelegate: class {
    func widgetView(_ widgetView: KFVWidget, didSelectCellForType type: KFVWidget.TouchedViewType)
    func widgetView(_ widgetView: KFVWidget, heightDidChange height: CGFloat)
}
