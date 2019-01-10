//
//  KFCVerifyDropoffImage.swift
//  KifuSF
//
//  Created by Erick Sanchez on 12/14/18.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import UIKit

//TODO: alex-remove this file?

class KFCVerifyDropoffImage: UIViewController {

    // MARK: - VARS
    
    var donation: Donation!
//
//    private lazy var labelTitle: UILabel! = {
//        let label = UILabel(forAutoLayout: ())
//        view.addSubview(label)
//        label.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
//
//        return label
//    }()
    
    @IBOutlet weak var imageView: UIImageView!
//    private lazy var imageViewVerification: UIImageView! = {
//        let imgView = UIImageView(forAutoLayout: ())
//        view.addSubview(imgView)
//        imgView.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
//        imgView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
//
//        return imgView
//    }()
//
//    private lazy var buttonConfirm: UIButton! = {
//        let button = UIButton(forAutoLayout: ())
//        view.addSubview(button)
//
//        return button
//    }()
    
    // MARK: - RETURN VALUES
    
    // MARK: - METHODS
    
    func presentModally(in viewController: UIViewController) {
        let navVc = UINavigationController(rootViewController: self)
        
        //TODO: alex-set up canel button
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(self.pressCancel(_:)))
        navVc.navigationItem.leftBarButtonItem = cancelButton
        
        viewController.present(navVc, animated: true)
    }
    
    //TODO: alex-outUnable to simultaneously satisfy constraints
//    override func loadView() {
//        super.loadView()
//
//        view.backgroundColor = .white
//
//        imageViewVerification.autoMatch(
//            .width,
//            to: .height,
//            of: imageViewVerification
//        )
//        imageViewVerification.autoPinEdge(
//            .leading,
//            to: .leading,
//            of: view,
//            withOffset: 32,
//            relation: .greaterThanOrEqual
//        )
//        imageViewVerification.autoCenterInSuperview()
//
//        let safeAreaGuide = view.safeAreaLayoutGuide
//        labelTitle.topAnchor.constraint(
//            equalTo: safeAreaGuide.topAnchor).isActive = true
//        labelTitle.autoPinEdge(
//            .leading,
//            to: .leading,
//            of: view,
//            withOffset: 15
//        )
//        view.autoPinEdge(
//            .trailing,
//            to: .trailing,
//            of: labelTitle,
//            withOffset: 15
//        )
//        labelTitle.autoPinEdge(
//            .top,
//            to: .bottom,
//            of: imageViewVerification,
//            withOffset: 8,
//            relation: .greaterThanOrEqual
//        )
//
//        buttonConfirm.autoPinEdge(
//            .leading,
//            to: .leading,
//            of: view,
//            withOffset: 15
//        )
//        view.autoPinEdge(
//            .trailing,
//            to: .trailing,
//            of: buttonConfirm,
//            withOffset: 15
//        )
//        buttonConfirm.bottomAnchor.constraint(
//            equalTo: safeAreaGuide.bottomAnchor).isActive = true
//
//        //
//    }
    
    /**
     - Precondition: donation.verificationUrl must not be nil
     */
    private func updateUI() {
//        labelTitle.text = "Validate the Volunteer's Dropoff Image"
        guard let verifcationString = donation.verificationUrl else {
            fatalError(KFErrorMessage.seriousBug)
        }
        
        if let url = URL(string: verifcationString) {
            imageView.kf.setImage(with: url)
//            imageViewVerification.kf.setImage(with: url)
        } else {
            UIAlertController(title: "Verifing the Dropoff", message: "Invalid verification url", preferredStyle: .alert)
                .addButton(title: "Dismiss", with: { [weak self] _ in
                    self?.presentingViewController?.dismiss(animated: true)
                })
                .present(in: self)
        }
        
//        buttonConfirm.setTitle("Confirm", for: .normal)
    }
    
    private func confirmDropoffImage() {
        DonationService.verifyDelivery(for: donation) { (isSuccessful) in
            if isSuccessful {
                self.presentingViewController?.dismiss(animated: true)
            } else {
                UIAlertController(errorMessage: nil)
                    .present(in: self)
            }
        }
    }
    
    // MARK: - IBACTIONS
    
    @objc func pressCancel(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true)
    }
    
    @IBAction func pressConfimDropoff(_ sender: Any) {
        UIAlertController(title: "Confirm Dropoff Image", message: "Are you sure you want to confrim this image?", preferredStyle: .actionSheet)
            .addButton(title: "Confirm Delivery", style: .destructive) { [weak self] _ in
                self?.confirmDropoffImage()
            }
            .addCancelButton()
            .present(in: self)
    }
    
    @IBAction func pressFlagImage(_ sender: Any) {
        let flaggingVc = FlaggingViewController(flaggableItems: [.flaggedVerificationImage], donation: donation)
        self.present(flaggingVc, animated: true)
    }
    
    // MARK: - LIFE CYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if donation.verificationUrl != nil {
            updateUI()
        } else {
            UIAlertController(
                title: "Verifing the Dropoff",
                message: "This donation does not contain a verificaiton url. Please try again later or contact us if this error continues.",
                preferredStyle: .alert)
                .addButton(title: "Dismiss", with: { [weak self] _ in
                    self?.presentingViewController?.dismiss(animated: true)
                })
                .present(in: self)
        }
    }

}
