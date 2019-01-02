//
//  KFCDisclaimer.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 14/10/2018.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import UIKit
import CoreLocation

/**
 - warning: This ViewController requires that the current user is set (see -continueButtonTapped
 for more)
 */
class KFCLocationServiceDisclaimer: UIScrollableViewController {
    //MARK: - Variables
    let locationServiceDisclaimerLabel = UILabel(font: UIFont.preferredFont(forTextStyle: .body), textColor: .kfSubtitle)
    
    let activateLocationButton = UIAnimatedButton(backgroundColor: .kfPrimary, andTitle: "Activate Location")
    let continueButton = UIAnimatedButton(backgroundColor: .kfPrimary, andTitle: "Continue")
    
    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureStyling()
        configureLayout()
        configureGestures()
    }
    
    @objc func continueButtonTapped() {
        
        //update firebase
        UserService.markHasApprovedConditionsTrue { (isSuccessful) in
            if isSuccessful {
                let disclaimerViewController = KFCPhoneNumberValidation()
                disclaimerViewController.modalPresentationStyle = .currentContext
                self.present(disclaimerViewController, animated: true)
            } else {
                UIAlertController(errorMessage: nil)
                    .present(in: self)
            }
        }
    }
    
    @objc func activateLocationButtonTapped() {
        locationManager.requestWhenInUseAuthorization()
    }
}

extension KFCLocationServiceDisclaimer: UIConfigurable {
    func configureGestures() {
        activateLocationButton.addTarget(self, action: #selector(activateLocationButtonTapped), for: .touchUpInside)
        continueButton.addTarget(self, action: #selector(continueButtonTapped), for: .touchUpInside)
    }
    
    func configureStyling() {
        view.backgroundColor = .kfWhite
        
        title = "Location Privacy"
        locationServiceDisclaimerLabel.text = "In order to use Kifu we will need to know you location only while using the app."
        
        if !CLLocationManager.locationServicesEnabled() {
            continueButton.isUserInteractionEnabled = false
        } else {
            activateLocationButton.isUserInteractionEnabled = false
        }
    }
    
    func configureLayout() {
        
        view.addSubview(contentScrollView)
        contentScrollView.addSubview(outerStackView)
        
        configureLayoutForOuterStackView()
    }
    
    func configureLayoutForOuterStackView() {
        outerStackView.addArrangedSubview(locationServiceDisclaimerLabel)
        outerStackView.addArrangedSubview(activateLocationButton)
        outerStackView.addArrangedSubview(continueButton)
    }
}
