//
//  HomeViewController.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 27/08/2018.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var donationsTableView: UITableView!
    
    private var openDonations: [Donation] = [] {
        didSet {
            donationsTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.tabBarItem.image = UIImage(named: "BoxIcon")
        navigationController?.tabBarItem.title = "Home"
        navigationItem.title = "Donations"
        
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        
        
        donationsTableView.dataSource = self
        donationsTableView.delegate = self
        
        donationsTableView.separatorStyle = .none
        
        var bounds = navigationController!.navigationBar.bounds
        bounds.size.height += 20
        bounds.origin.y -= 20
        
        let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .light))
        visualEffectView.isUserInteractionEnabled = false
        visualEffectView.frame = bounds
        visualEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        self.navigationController?.navigationBar.addSubview(visualEffectView)
        visualEffectView.layer.zPosition = -1
        
        if let widgetView = Bundle.main.loadNibNamed("KFWidgetView", owner: self, options: nil)?.first as? KFWidgetView {
            view.addSubview(widgetView)
            
            widgetView.translatesAutoresizingMaskIntoConstraints = false
            
            widgetView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
            widgetView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
            widgetView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        }
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //TODO: retrieve open donations in viewDidLoad maybe?
        DonationService.showTimelineDonations { (donations) in
            self.openDonations = donations
        }
    }

}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return openDonations.count
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let donationCell = donationsTableView.dequeueReusableCell(withIdentifier: "donationCell") as? DonationTableViewCell else {
            fatalError("unknown donation table view cell")
        }

        return donationCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 152
    }
    
    
}

extension HomeViewController: UITableViewDelegate {
    
}
