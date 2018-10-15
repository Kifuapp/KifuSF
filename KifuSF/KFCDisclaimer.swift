//
//  KFCDisclaimer.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 14/10/2018.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import UIKit

class KFCDisclaimer: UIViewController, UIConfigurable {
    
    let contentScrollView = UIScrollView()
    let outerStackView = UIStackView(axis: .vertical, alignment: .fill, spacing: KFPadding.StackView, distribution: .fill)
    
    let disclaimerLabel = UILabel(font: UIFont.preferredFont(forTextStyle: .body), textColor: .kfSubtitle)
    let activateLocationButton = KFButton(backgroundColor: .kfPrimary, andTitle: "Activate Location")
    let continueButton = KFButton(backgroundColor: .kfPrimary, andTitle: "Continue")
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(contentScrollView)
        contentScrollView.addSubview(outerStackView)
        
        configureStyling()
        configureLayoutConstraints()
        configureGestures()
    }
    
    func configureGestures() {
        activateLocationButton.addTarget(self, action: #selector(activateLocationButtonTapped), for: .touchUpInside)
        continueButton.addTarget(self, action: #selector(continueButtonTapped), for: .touchUpInside)
    }
    
    @objc func continueButtonTapped() {
        print("continue")
    }
    
    @objc func activateLocationButtonTapped() {
        print("I want to know where you live")
    }
    
    func configureStyling() {
        view.backgroundColor = .kfSuperWhite
        
        contentScrollView.alwaysBounceVertical = true
        
        title = "Terms and Conditions"
        disclaimerLabel.text = "In order to use Kifu we will need to know you location only while using the app. \n\nBy continuing you agree to our Terms and Privacy Policy"
    }
    
    func configureLayoutConstraints() {
        
        configureLayoutForOuterStackView()
        
        configureConstraintsForContentScrollView()
        configureConstraintsForOuterStackView()
    }
    
    func configureLayoutForOuterStackView() {
        outerStackView.addArrangedSubview(disclaimerLabel)
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
