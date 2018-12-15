//
//  KFCVerifyDropoffImage.swift
//  KifuSF
//
//  Created by Erick Sanchez on 12/14/18.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import UIKit

class KFCVerifyDropoffImage: UIViewController {

    // MARK: - VARS
    
    var donation: Donation!
    
    private lazy var labelTitle: UILabel! = {
        let label = UILabel(forAutoLayout: ())
        view.addSubview(label)
        label.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        
        return label
    }()
    
    private lazy var imageViewVerification: UIImageView! = {
        let imgView = UIImageView(forAutoLayout: ())
        view.addSubview(imgView)
        imgView.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        imgView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        
        return imgView
    }()
    
    private lazy var buttonConfirm: UIButton! = {
        let button = UIButton(forAutoLayout: ())
        view.addSubview(button)
        
        return button
    }()
    
    // MARK: - RETURN VALUES
    
    // MARK: - METHODS
    
    func presentModally(in viewController: UIViewController) {
        let navVc = UINavigationController(rootViewController: self)
        
        //set up canel button
        
        viewController.present(navVc, animated: true)
    }
    
    override func loadView() {
        super.loadView()
        
        view.backgroundColor = .white
        
        //TODO: Unable to simultaneously satisfy constraints
        
        imageViewVerification.autoMatch(
            .width,
            to: .height,
            of: imageViewVerification
        )
        imageViewVerification.autoPinEdge(
            .leading,
            to: .leading,
            of: view,
            withOffset: 32,
            relation: .greaterThanOrEqual
        )
        imageViewVerification.autoCenterInSuperview()
        
        let safeAreaGuide = view.safeAreaLayoutGuide
        labelTitle.topAnchor.constraint(
            equalTo: safeAreaGuide.topAnchor).isActive = true
        labelTitle.autoPinEdge(
            .leading,
            to: .leading,
            of: view,
            withOffset: 15
        )
        view.autoPinEdge(
            .trailing,
            to: .trailing,
            of: labelTitle,
            withOffset: 15
        )
        labelTitle.autoPinEdge(
            .top,
            to: .bottom,
            of: imageViewVerification,
            withOffset: 8,
            relation: .greaterThanOrEqual
        )
        
        buttonConfirm.autoPinEdge(
            .leading,
            to: .leading,
            of: view,
            withOffset: 15
        )
        view.autoPinEdge(
            .trailing,
            to: .trailing,
            of: buttonConfirm,
            withOffset: 15
        )
        buttonConfirm.bottomAnchor.constraint(
            equalTo: safeAreaGuide.bottomAnchor).isActive = true
        
        //
    }
    
    private func updateUI() {
        labelTitle.text = "Validate the Volunteer's Dropoff Image"
        if let url = URL(string: donation.imageUrl) {
            imageViewVerification.kf.setImage(with: url)
        } else {
            
        }
        
        buttonConfirm.setTitle("Confirm", for: .normal)
    }
    
    // MARK: - IBACTIONS
    
    // MARK: - LIFE CYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateUI()
    }

}
