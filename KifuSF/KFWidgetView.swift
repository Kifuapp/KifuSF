//
//  KFWidgetView.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 28/08/2018.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import UIKit

protocol KFPWidgetInfo {
    var title: String { get }
    var subtitle: String { get }
}

class KFWidgetView: UIView {
    
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
    
    @IBOutlet weak var containerStackView: UIStackView!
    @IBOutlet weak var deliveryStackView: UIStackView!
    @IBOutlet weak var donationStackView: UIStackView!
    
    @IBOutlet weak var deliveryTitleLabel: UILabel!
    @IBOutlet weak var deliverySubtitleLabel: UILabel!
    @IBOutlet weak var deliveryBackgroundView: UIView!
    
    @IBOutlet weak var deliveryDisclosureImageView: UIImageView!
    
    @IBOutlet weak var donationTitleLabel: UILabel!
    @IBOutlet weak var donationSubtitleLabel: UILabel!
    @IBOutlet weak var donationBackgroundView: UIView!
    
    @IBOutlet weak var donationDisclosureImageView: UIImageView!
    
    static let nibName = "KFWidgetView"
    
    var dataSource: KFWidgetViewDataSource?
    var delegate: KFWidgetViewDelegate?

    var lastTouchLocation: CGPoint?
    var touchedViewType: TouchedViewType? {
        willSet {
            touchedViewType?.backgroundView().unhighlight()
        }
        
        didSet {
            touchedViewType?.backgroundView().highlight()
        }
    }
    
    override func awakeFromNib() {
        
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

    @objc func updateWidgetView(_ sender: UILongPressGestureRecognizer) {
        let touchLocation = sender.location(in: containerStackView)
        lastTouchLocation = touchLocation
        
        switch sender.state {
        case .began:
            updateState(for: touchLocation)
            
        case .changed:
            updateState(for: touchLocation)

        case .ended:
            updateState(for: touchLocation)
            if let type = touchedViewType {
                delegate?.widgetView(self, didSelectCellForType: type)
            }
            touchedViewType = nil
            
        default:
            break
        }
    }
    
    func updateState(for location: CGPoint) {
        if deliveryStackView.frame.contains(location)  {
            touchedViewType = .delivery(deliveryBackgroundView)
        } else {
            touchedViewType = .donation(donationBackgroundView)
        }
    }
    
    func updateInfo() {
        if let deliveryInfo = dataSource?.widgetView(self, cellInfoForType: .delivery(deliveryBackgroundView)) {
            deliveryTitleLabel.text = "Delivery - \(deliveryInfo.title)"
            deliverySubtitleLabel.text = deliveryInfo.subtitle
        }
        
        if let donationInfo = dataSource?.widgetView(self, cellInfoForType: .donation(donationBackgroundView)) {
            donationTitleLabel.text = "Donation - \(donationInfo.title)"
            donationSubtitleLabel.text = donationInfo.subtitle
        }
    }
    
    func reloadData() {
        updateInfo()
    }

}

protocol KFWidgetViewDataSource {
    func widgetView(_ widgetView: KFWidgetView, cellInfoForType type: KFWidgetView.TouchedViewType) -> KFPWidgetInfo
}

protocol KFWidgetViewDelegate {
    func widgetView(_ widgetView: KFWidgetView, didSelectCellForType type: KFWidgetView.TouchedViewType)
}
