//
//  ItemDetailViewController.swift
//  KifuSF
//
//  Created by Shutaro Aoyama on 2018/07/29.
//  Copyright © 2018年 Alexandru Turcanu. All rights reserved.
//

import UIKit

enum DeliveryDonationState {
    case donationIsNotAlreadyRequested
    case donationIsAlreadyRequested
    case userAlreadyHasAnOpenDelivery
}

class ItemDetailViewController: UIViewController {
    
    var donation: Donation!
    
    var userHasAlreadyRequestedDonation: DeliveryDonationState = .donationIsNotAlreadyRequested
    
    /** this also disables the view's isUserInteractive */
    private var isRequestButtonEnabled: Bool {
        set {
            requestButtonView.alpha = newValue ? 1.0 : 0.45
            requestButtonView.isUserInteractionEnabled = newValue
            view.isUserInteractionEnabled = newValue
            barButtonDone.isEnabled = newValue
        }
        get {
            return view.isUserInteractionEnabled
        }
    }
    
    /** this also disables the view's isUserInteractive */
    private var isCancelRequestButtonEnabled: Bool {
        set {
            viewCancelRequestButton.alpha = newValue ? 1.0 : 0.45
            viewCancelRequestButton.isUserInteractionEnabled = newValue
            view.isUserInteractionEnabled = newValue
            barButtonDone.isEnabled = newValue
        }
        get {
            return view.isUserInteractionEnabled
        }
    }
    
    // MARK: - RETURN VALUES
    
    // MARK: - VOID METHODS
    
    private func updateUI() {
        itemImage.kf.setImage(with: URL(string: donation.imageUrl)!)
        itemName.text = donation.title
        
        itemDistance.text = UserService.calculateDistance(long: donation.longitude, lat: donation.laditude)
        postDetail.text = "@\(donation.donator.username)"
        descriptionView.text = donation.notes
        
        //request button
        switch userHasAlreadyRequestedDonation {
        case .donationIsNotAlreadyRequested:
            setActionButton(to: .showingRequestButton)
        case .donationIsAlreadyRequested:
            setActionButton(to: .showingCancelRequestButton)
        case .userAlreadyHasAnOpenDelivery:
            setActionButton(to: .showingLimitOneDeliveryMessage)
        }
    }
    
    fileprivate enum ActionButtonState {
        case showingRequestButton
        case showingCancelRequestButton
        case showingLimitOneDeliveryMessage
    }
    
    private func setActionButton(to newState: ActionButtonState) {
        switch newState {
        case .showingRequestButton:
            requestButtonView.isHidden = false
            viewCancelRequestButton.isHidden = true
            labelLimitOneDeliveryMessage.isHidden = true
        case .showingCancelRequestButton:
            requestButtonView.isHidden = true
            viewCancelRequestButton.isHidden = false
            labelLimitOneDeliveryMessage.isHidden = true
        case .showingLimitOneDeliveryMessage:
            requestButtonView.isHidden = true
            viewCancelRequestButton.isHidden = true
            labelLimitOneDeliveryMessage.isHidden = false
        }
    }
    
    // MARK: - IBACTIONS
    
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var itemDistance: UILabel!
    @IBOutlet weak var postDetail: UILabel!
    @IBOutlet weak var descriptionView: UITextView!
    @IBOutlet weak var itemImage: UIImageView!
    
    @IBOutlet weak var requestButtonView: UIView!
    @IBOutlet weak var barButtonDone: UIBarButtonItem!
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        self.navigationController!.popViewController(animated: true)
    }
    
    @IBAction func requestButtonTapped(_ sender: Any) {
        self.isRequestButtonEnabled = false
        
        RequestService.createRequest(for: donation) { success in
            if success {
                self.navigationController!.popViewController(animated: true)
            } else {
                let alert = UIAlertController(errorMessage: nil)
                self.present(alert, animated: true)
                
                self.isRequestButtonEnabled = true
            }
        }
    }
    
    @IBOutlet weak var labelLimitOneDeliveryMessage: UILabel!
    
    @IBOutlet weak var viewCancelRequestButton: UIView!
    @IBAction func pressCancelRequestButton(_ sender: Any) {
        self.isCancelRequestButtonEnabled = false
        
        RequestService.cancelRequest(for: donation) { success in
            if success {
                self.navigationController!.popViewController(animated: true)
            } else {
                let alert = UIAlertController(errorMessage: nil)
                self.present(alert, animated: true)
                
                self.isCancelRequestButtonEnabled = true
            }
        }
    }
    
    // MARK: - LIFE CYCLE
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController!.setNavigationBarHidden(true, animated: true)
        
        updateUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController!.setNavigationBarHidden(false, animated: true)
    }

}

fileprivate extension ItemDetailViewController.ActionButtonState {
    
    var isShowingRequestButton: Bool {
        switch self {
        case .showingRequestButton:
            return true
        default:
            return false
        }
    }
    
    var isShowingCancelRequestButton: Bool {
        switch self {
        case .showingCancelRequestButton:
            return true
        default:
            return false
        }
    }
    
    var isShowingLimitOneDeliveryMessage: Bool {
        switch self {
        case .showingLimitOneDeliveryMessage:
            return true
        default:
            return false
        }
    }
    
}
