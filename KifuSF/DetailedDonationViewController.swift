//
//  DetailedDonationViewController.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 29/08/2018.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import UIKit

class DetailedDonationViewController: UIViewController {
    
    @IBOutlet weak var requestDeliveryButton: UIButton!
    @IBOutlet weak var donationTableView: UITableView!
    
    @IBAction func requestDeliveryButtonPressed(_ sender: Any) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpDonationTableView()
        
        requestDeliveryButton.setTitle("Request Delivery", for: .normal)        
        requestDeliveryButton.setUp(with: .button, andColor: .kfPrimary)
        
        title = "Donation"
        view.backgroundColor = UIColor.kfWhite
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: .kfFlagIcon,
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(flagButtonPressed))
    }
    
    
    @objc func flagButtonPressed() {
        //TODO: flagging
    }
    
    func setUpDonationTableView() {
        donationTableView.registerTableViewCell(for: KFVDonationDescriptionCell.self)
        donationTableView.dataSource = self
    }

}

extension DetailedDonationViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = donationTableView.dequeueReusableCell(withIdentifier: KFVDonationDescriptionCell.reuseIdentifier, for: indexPath) as? KFVDonationDescriptionCell else {
            fatalError(KFErrorMessage.unknownCell)
        }
        
        return cell
    }
    
    
}
