//
//  DonationRequirementsViewController.swift
//  KifuSF
//
//  Created by Noah Woodward on 1/9/19.
//  Copyright © 2019 Alexandru Turcanu. All rights reserved.
//

import UIKit

class DonationRequirementsViewController: UIViewController {
    private let donationRequirementsTextView = UITextView()
    override func viewDidLoad() {
        super.viewDidLoad()

        configureTextViewConstraints()
        configureTextViewContent()
    }
    
    
    func configureTextViewConstraints(){
        view.addSubview(donationRequirementsTextView)
        donationRequirementsTextView.autoPinEdge(toSuperviewEdge: .top)
        donationRequirementsTextView.autoPinEdge(toSuperviewEdge: .leading)
        donationRequirementsTextView.autoPinEdge(toSuperviewEdge: .trailing)
        donationRequirementsTextView.autoPinEdge(toSuperviewEdge: .bottom)
    }
    
    func configureTextViewContent(){
        donationRequirementsTextView.isUserInteractionEnabled = false
        donationRequirementsTextView.font = UIFont.preferredFont(forTextStyle: .body)
        DonationRequirementsService.getRequirementsText { (requirementsText) in
            if let requirementsText = requirementsText {
                self.donationRequirementsTextView.text = requirementsText
            } else{
                self.donationRequirementsTextView.text = "Unable to Retrieve Requirements Text"
            }
        }
        

        
    }
    


}
