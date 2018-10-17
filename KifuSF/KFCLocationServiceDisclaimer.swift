//
//  KFCDisclaimer.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 14/10/2018.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import UIKit
import CoreLocation

class KFCLocationServiceDisclaimer: UIViewController, UIConfigurable {
    
    let contentScrollView = UIScrollView()
    let outerStackView = UIStackView(axis: .vertical, alignment: .fill, spacing: KFPadding.StackView, distribution: .fill)
    
    let locationServiceDisclaimerLabel = UILabel(font: UIFont.preferredFont(forTextStyle: .body), textColor: .kfSubtitle)
    
    let activateLocationButton = KFButton(backgroundColor: .kfPrimary, andTitle: "Activate Location")
    let continueButton = KFButton(backgroundColor: .kfPrimary, andTitle: "Continue")
    
    let locationManager = CLLocationManager()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        configureStyling()
        configureLayoutConstraints()
        configureGestures()
    }
    
    func configureGestures() {
        activateLocationButton.addTarget(self, action: #selector(activateLocationButtonTapped), for: .touchUpInside)
        continueButton.addTarget(self, action: #selector(continueButtonTapped), for: .touchUpInside)
    }
    
    @objc func continueButtonTapped() {
        let disclaimerViewController = UINavigationController(rootViewController: KFCPhoneNumberValidation())
        disclaimerViewController.modalPresentationStyle = .currentContext
        present(disclaimerViewController, animated: true)
//        self.view.window?.setRootViewController(disclaimerViewController)
    }
    
    @objc func activateLocationButtonTapped() {
        locationManager.requestWhenInUseAuthorization()
    }
    
    func configureStyling() {
        view.backgroundColor = .kfSuperWhite
        
        contentScrollView.alwaysBounceVertical = true
        
        title = "Location Privacy"
        locationServiceDisclaimerLabel.text = "In order to use Kifu we will need to know you location only while using the app."
        
        if !CLLocationManager.locationServicesEnabled() {
            continueButton.isUserInteractionEnabled = false
        } else {
            activateLocationButton.isUserInteractionEnabled = false
        }
    }
    
    func configureLayoutConstraints() {
        
        view.addSubview(contentScrollView)
        contentScrollView.addSubview(outerStackView)
        
        configureLayoutForOuterStackView()
        
        configureConstraintsForContentScrollView()
        configureConstraintsForOuterStackView()
    }
    
    func configureLayoutForOuterStackView() {
        outerStackView.addArrangedSubview(locationServiceDisclaimerLabel)
        outerStackView.addArrangedSubview(activateLocationButton)
        outerStackView.addArrangedSubview(continueButton)
    }
    
    func configureConstraintsForOuterStackView() {
        outerStackView.translatesAutoresizingMaskIntoConstraints = false
        
        outerStackView.autoMatch(.width, to: .width, of: view, withOffset: -32)
        
        outerStackView.autoPinEdge(toSuperviewEdge: .top, withInset: KFPadding.SuperView)
        outerStackView.autoPinEdge(toSuperviewEdge: .leading, withInset: KFPadding.SuperView)
        outerStackView.autoPinEdge(toSuperviewEdge: .trailing, withInset: KFPadding.SuperView)
        outerStackView.autoPinEdge(toSuperviewEdge: .bottom, withInset: 0)
    }
    
    func configureConstraintsForContentScrollView() {
        contentScrollView.translatesAutoresizingMaskIntoConstraints = false
        contentScrollView.autoPinEdgesToSuperviewEdges()
    }
    
}
