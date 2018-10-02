//
//  KFWidgetView.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 28/08/2018.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import UIKit



//MARK: KFVWidget
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
    
    let deliveryEmptyView = UIView()
    let deliveryIconView = KFIconView(image: .kfDeliveryIcon)
    
    let deliveryTextBodyStackView = UIStackView(axis: .vertical, alignment: .fill, distribution: .fillEqually)
    let deliveryTitleLabel = KFLabel(font: UIFont.preferredFont(forTextStyle: .headline), textColor: .kfTitle)
    let deliverySubtitleLabel = KFLabel(font: UIFont.preferredFont(forTextStyle: .subheadline), textColor: .kfSubtitle)
    
    let deliveryDisclosureImageView = UIImageView()
    let deliverySpacer = UIView()
    
    let donationStackView = UIStackView(axis: .vertical, alignment: .fill, distribution: .fill)
    let donationContentsStackView = UIStackView(axis: .horizontal, alignment: .center, spacing: 16, distribution: .fill)
    
    let donationEmptyView = UIView()
    let donationIconView = KFIconView(image: .kfDonationIcon)
    
    let donationTextBodyStackView = UIStackView(axis: .vertical, alignment: .fill, distribution: .fillEqually)
    let donationTitleLabel = KFLabel(font: UIFont.preferredFont(forTextStyle: .headline), textColor: .kfTitle)
    let donationSubtitleLabel = KFLabel(font: UIFont.preferredFont(forTextStyle: .subheadline), textColor: .kfSubtitle)
    
    let donationDisclosureImageView = UIImageView()
    let donationSpacer = UIView()
    
    static let nibName = "KFVWidget"
    
    weak var dataSource: KFPWidgetDataSource?
    weak var delegate: KFPWidgetDelegate?

    private var lastTouchLocation: CGPoint?
    private var touchedViewType: TouchedViewType? {
        didSet {
            switch touchedViewType {
            case .donation?:
                donationBackgroundView.backgroundColor = UIColor.kfWhite.darker(by: 5)
                deliveryBackgroundView.backgroundColor = UIColor.kfWhite
            case .delivery?:
                donationBackgroundView.backgroundColor = UIColor.kfWhite
                deliveryBackgroundView.backgroundColor = UIColor.kfWhite.darker(by: 5)
            case .none:
                donationBackgroundView.backgroundColor = UIColor.kfWhite
                deliveryBackgroundView.backgroundColor = UIColor.kfWhite
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
    }
    
    func configureLayoutConstraints() {
        configureDeliveryViewLayout()
        configureDonationViewLayout()
        configureStackViewsLayout()
        
        addSubview(backgroundsStackView)
        addSubview(containerStackView)
        
        deliveryEmptyView.translatesAutoresizingMaskIntoConstraints = false
        donationEmptyView.translatesAutoresizingMaskIntoConstraints = false
        
        deliveryEmptyView.autoSetDimension(.width, toSize: 0)
        donationEmptyView.autoSetDimension(.width, toSize: 0)
        
        deliverySpacer.translatesAutoresizingMaskIntoConstraints = false
        donationSpacer.translatesAutoresizingMaskIntoConstraints = false
        
        deliverySpacer.autoSetDimension(.height, toSize: 0.5)
        donationSpacer.autoSetDimension(.height, toSize: 0.5)
        
        configureIconsConstraints()
        configureTextPadding()
        configureStackViewsPadding()
    }
    
    private func configureIconsConstraints() {
        deliveryIconView.translatesAutoresizingMaskIntoConstraints = false
        donationIconView.translatesAutoresizingMaskIntoConstraints = false
        
        donationIconView.autoMatch(.height, to: .height, of: deliveryIconView)
        donationIconView.autoMatch(.width, to: .width, of: deliveryIconView)
    }
    
    private func configureTextPadding() {
        deliveryTextBodyStackView.translatesAutoresizingMaskIntoConstraints = false
        donationTextBodyStackView.translatesAutoresizingMaskIntoConstraints = false
        
        deliveryTextBodyStackView.autoPinEdge(toSuperviewEdge: .top, withInset: KFPadding.ContentView)
        deliveryTextBodyStackView.autoPinEdge(toSuperviewEdge: .bottom, withInset: KFPadding.ContentView)
        
        donationTextBodyStackView.autoPinEdge(toSuperviewEdge: .top, withInset: KFPadding.ContentView)
        donationTextBodyStackView.autoPinEdge(toSuperviewEdge: .bottom, withInset: KFPadding.ContentView)
    }
    
    private func configureStackViewsPadding() {
        containerStackView.translatesAutoresizingMaskIntoConstraints = false
        containerStackView.autoPinEdgesToSuperviewEdges()
        
        backgroundsStackView.translatesAutoresizingMaskIntoConstraints = false
        backgroundsStackView.autoPinEdgesToSuperviewEdges()
    }
    
    private func configureStackViewsLayout() {
        containerStackView.addArrangedSubview(deliveryStackView)
        containerStackView.addArrangedSubview(donationStackView)
        
        backgroundsStackView.addArrangedSubview(deliveryBackgroundView)
        backgroundsStackView.addArrangedSubview(donationBackgroundView)
    }
    
    private func configureDeliveryViewLayout() {
        deliveryTextBodyStackView.addArrangedSubview(deliveryTitleLabel)
        deliveryTextBodyStackView.addArrangedSubview(deliverySubtitleLabel)
        
        deliveryContentsStackView.addArrangedSubview(deliveryEmptyView)
        deliveryContentsStackView.addArrangedSubview(deliveryIconView)
        deliveryContentsStackView.addArrangedSubview(deliveryTextBodyStackView)
        deliveryContentsStackView.addArrangedSubview(deliveryDisclosureImageView)
        
        deliveryStackView.addArrangedSubview(deliveryContentsStackView)
        deliveryStackView.addArrangedSubview(deliverySpacer)
    }
    
    private func configureDonationViewLayout() {
        donationTextBodyStackView.addArrangedSubview(donationTitleLabel)
        donationTextBodyStackView.addArrangedSubview(donationSubtitleLabel)
        
        donationContentsStackView.addArrangedSubview(donationEmptyView)
        donationContentsStackView.addArrangedSubview(donationIconView)
        donationContentsStackView.addArrangedSubview(donationTextBodyStackView)
        donationContentsStackView.addArrangedSubview(donationDisclosureImageView)
        
        donationStackView.addArrangedSubview(donationContentsStackView)
        donationStackView.addArrangedSubview(donationSpacer)
    }
    
    func configureStyling() {
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
        lastTouchLocation = touchLocation
        
        switch sender.state {
        case .began:
            updateState(for: touchLocation)
            
        case .changed:
            updateState(for: touchLocation)

        case .ended:
            updateState(for: touchLocation)
            //TODO: check if it's inside
            if let type = touchedViewType {
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
        } else {
            touchedViewType = .donation
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
