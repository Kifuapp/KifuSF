//
//  KFWidgetView.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 28/08/2018.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import UIKit



//MARK: KFVWidget
final class KFVWidget: UIView {
    
    enum TouchedViewType {
        case donation(UIView)
        case delivery(UIView)
        
        func backgroundView() -> UIView {
            switch self {
            case .donation(let view):
                return view
            case .delivery(let view):
                return view
                
            }
        }
    }
    
    public struct KFMWidgetInfo: KFPWidgetInfo {
        let title: String
        let subtitle: String
    }
    
    @IBOutlet private weak var containerStackView: UIStackView!
    @IBOutlet private weak var deliveryStackView: UIStackView!
    @IBOutlet private weak var donationStackView: UIStackView!

    @IBOutlet private weak var deliveryTitleLabel: UILabel!
    @IBOutlet private weak var deliverySubtitleLabel: UILabel!
    @IBOutlet private weak var deliveryBackgroundView: UIView!

    @IBOutlet private weak var deliveryDisclosureImageView: UIImageView!

    @IBOutlet private weak var donationTitleLabel: UILabel!
    @IBOutlet private weak var donationSubtitleLabel: UILabel!
    @IBOutlet private weak var donationBackgroundView: UIView!

    @IBOutlet private weak var donationDisclosureImageView: UIImageView!
    
//    let containerStackView = UIStackView()
//
//    let deliveryStackView = UIStackView()
//    let deliveryTitleLabel = UILabel()
//    let deliverySubtitleLabel = UILabel()
//    let deliveryDisclosureImageView = UIImageView()
//
//    let donationStackView = UIStackView()
//    let donationTitleLabel = UILabel()
//    let donationSubtitleLabel = UILabel()
//    let donationDisclosureImageView = UIImageView()
    
    let spacer = UIView()
    
    static let nibName = "KFVWidget"
    
    weak var dataSource: KFPWidgetDataSource?
    weak var delegate: KFPWidgetDelegate?

    private var lastTouchLocation: CGPoint?
    private var touchedViewType: TouchedViewType? {
        willSet {
            touchedViewType?.backgroundView().unhighlight()
        }
        
        didSet {
            touchedViewType?.backgroundView().highlight()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        deliveryTitleLabel.setUp(with: .body1)
        deliverySubtitleLabel.setUp(with: .header2)
        donationTitleLabel.setUp(with: .body1)
        donationSubtitleLabel.setUp(with: .header2)
        
        deliveryDisclosureImageView.tintColor = UIColor.kfPrimary
        donationDisclosureImageView.tintColor = UIColor.kfPrimary
        
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(updateWidgetView))
        longPress.minimumPressDuration = 0
        longPress.allowableMovement = 10
        
        containerStackView.addGestureRecognizer(longPress)
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
            touchedViewType = .delivery(deliveryBackgroundView)
        } else {
            touchedViewType = .donation(donationBackgroundView)
        }
    }
    
    private func updateInfo() {
        if let deliveryInfo = dataSource?.widgetView(self, cellInfoForType: .delivery(deliveryBackgroundView)) {
            deliveryStackView.isHidden = false
            deliveryBackgroundView.isHidden = false
            
            deliveryTitleLabel.text = "Delivery - \(deliveryInfo.title)"
            deliverySubtitleLabel.text = deliveryInfo.subtitle
        } else {
            deliveryStackView.isHidden = true
            deliveryBackgroundView.isHidden = true
        }
        
        if let donationInfo = dataSource?.widgetView(self, cellInfoForType: .donation(donationBackgroundView)) {
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
