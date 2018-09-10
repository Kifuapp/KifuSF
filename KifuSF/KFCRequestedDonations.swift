//
//  KFCRequestedDonations.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 06/09/2018.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import UIKit

class KFCRequestedDonations: UIViewController {
    
    @IBOutlet weak var requestedDonationsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Requested Donations"
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dismissVC))

//        requestedDonationsTableView.registerTableViewCell(for: KFVRequestedDonationCell.self)
        requestedDonationsTableView.register(KFVRequestedDonationCell.self, forCellReuseIdentifier: KFVRequestedDonationCell.id)
        requestedDonationsTableView.dataSource = self
        requestedDonationsTableView.rowHeight = 152
    }
    
    @objc func dismissVC() {
        dismiss(animated: true, completion: nil)
    }
}

extension KFCRequestedDonations: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
        //TODO: return actual amount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let requestedDonationCell = requestedDonationsTableView.dequeueReusableCell(withIdentifier: KFVRequestedDonationCell.id, for: indexPath) as? KFVRequestedDonationCell else {
            fatalError(KFErrorMessage.unknownCell)
        }
        
        requestedDonationCell.delegate = self
        //TODO: hook up with firebase
        //for now setup the cell by changing the iboutlets directly
        
//        requestedDonationCell.titleLabel
//        requestedDonationCell.distanceLabel
        
        return requestedDonationCell
    }
}

extension KFCRequestedDonations: KFPRequestedDonationCellDelegate {
    func didPressButton() {
        print("cancel button pressed")
        
        //TODO: hook up with firebase
    }
}
