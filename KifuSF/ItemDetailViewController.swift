//
//  ItemDetailViewController.swift
//  KifuSF
//
//  Created by Shutaro Aoyama on 2018/07/29.
//  Copyright © 2018年 Alexandru Turcanu. All rights reserved.
//

import UIKit

class ItemDetailViewController: UIViewController {
    
    var donation: Donation!
    
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
    
    // MARK: - RETURN VALUES
    
    // MARK: - VOID METHODS
    
    private func updateUI() {
        itemImage.kf.setImage(with: URL(string: donation.imageUrl)!)
        itemName.text = donation.title
        //TODO: distance
//        itemDistance.text =
        postDetail.text = donation.donator.username
        descriptionView.text = donation.notes
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
