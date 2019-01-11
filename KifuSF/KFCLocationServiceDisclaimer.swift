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
    let locationServiceDisclaimerLabel = UILabel(font: UIFont.preferredFont(forTextStyle: .body),
                                                 textColor: UIColor.Text.SubHeadline)
    
    let activateLocationButton = UIAnimatedButton(backgroundColor: UIColor.Pallete.Green,
                                                  andTitle: "Activate Location")
    let continueButton = UIAnimatedButton(backgroundColor: UIColor.Pallete.Green,
                                          andTitle: "Continue")
    
    let locationManager = CLLocationManager()
    
    private func updateUI() {
        
        // update buttons based on location services
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
            case .notDetermined, .restricted, .denied:
                activateLocationButton.isUserInteractionEnabled = true
                continueButton.isUserInteractionEnabled = false
            case .authorizedAlways, .authorizedWhenInUse:
                activateLocationButton.isUserInteractionEnabled = false
                continueButton.isUserInteractionEnabled = true
            }
        } else {
            activateLocationButton.isUserInteractionEnabled = true
            continueButton.isUserInteractionEnabled = false
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureStyling()
        configureLayout()
        configureGestures()
        
        NotificationCenter.default.addObserver(forName: .UIApplicationDidBecomeActive, object: nil, queue: nil) { [weak self] _ in
            self?.updateUI()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateUI()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func continueButtonTapped() {
        
        //update firebase
        UserService.markHasApprovedConditionsTrue { (isSuccessful) in
            if isSuccessful {
                UserService.updateCurrentUser(
                    key: \User.hasApprovedConditions, to: true,
                    writeToUserDefaults: false
                )
                OnBoardingDistributer.presentNextStepIfNeeded(from: self)
            } else {
                UIAlertController(errorMessage: nil)
                    .present(in: self)
            }
        }
    }
    
    @objc func activateLocationButtonTapped() {
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        default:
            ApplicationService.presentSettingsAlert(
                message: "Allow Kifu to use your location while the app is open.",
                in: self
            )
        }
    }
}

extension KFCLocationServiceDisclaimer: UIConfigurable {
    func configureGestures() {
        activateLocationButton.addTarget(self, action: #selector(activateLocationButtonTapped), for: .touchUpInside)
        continueButton.addTarget(self, action: #selector(continueButtonTapped), for: .touchUpInside)
    }
    
    func configureStyling() {
        view.backgroundColor = UIColor.Pallete.White
        
        title = "Location Privacy"
        locationServiceDisclaimerLabel.text = """
        In order to use Kifu we will need to know your location only while using the app.
        
        Your phone number is required to be verified. Phone Numbers are only shown after the following cases:
        If the donator accepts your request when you request to pick up their donation.
        
        If you accept a volunteer's request when you post a donation.
        
        Pick up addresses are only shown after you as the donator accepts a volunteer's request.
        
        Please allow Kifu to use your location while the app is open.
        """
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
