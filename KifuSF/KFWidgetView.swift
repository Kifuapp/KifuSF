//
//  KFWidgetView.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 28/08/2018.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import UIKit

class KFWidgetView: UIView {
    
    enum TouchedViewType {
        case donation(UIView)
        case delivery(UIView)
        case none
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
    var touchedView: TouchedViewType?
    
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
//        let touchLocation = sender.location(in: containerStackView)
//        lastTouchLocation = touchLocation
//        
//        switch sender.state {
//        case .began:
//            updateState(for: touchLocation)
//            
//        case .changed:
//            updateState(for: touchLocation)
//
//        case .ended:
//            updateState(for: touchLocation)
//
//        default:
//            break
//        }
    }
    
//    func updateState(for location: CGPoint) {
//        if deliveryStackView.frame.contains(location)  {
//            touchedView = .delivery
//            highlight(deliveryBackgroundView)
//            unhighlightView(donationBackgroundView)
//        } else {
//            touchedView = .donation
//            highlight(donationBackgroundView)
//            unhighlightView(deliveryBackgroundView)
//        }
//    }
//
//    func updateHighlightedViews() {
//        switch touchedView {
//        case .delivery:
//            <#code#>
//        case .donation:
//
//        case .none:
//
//        default:
//            <#code#>
//        }
//    }
    
    func highlight(_ view: UIView) {
        view.backgroundColor = UIColor.kfHighlight
    }

    func unhighlightView(_ view: UIView) {
        view.backgroundColor = UIColor.clear
    }

}

protocol KFWidgetViewDataSource {
//    func donationDescription() -> KFMDEscription
//    func deliveryDescription() -> KFMDEscription
}

@objc protocol KFWidgetViewDelegate {
    func didSelectDelivery()
    func didSelectDonation()
    @objc optional func didHighlightDelivery()
    @objc optional func didHighlightDonation()
}
