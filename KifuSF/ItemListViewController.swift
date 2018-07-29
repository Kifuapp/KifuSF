//
//  ItemListViewController.swift
//  KifuSF
//
//  Created by Shutaro Aoyama on 2018/07/28.
//  Copyright © 2018年 Alexandru Turcanu. All rights reserved.
//

import UIKit
import CoreLocation
import LocationPicker

class ItemListViewController: UIViewController {
    
    var openDonations: [Donation] = [] {
        didSet {
            postTable.reloadData()
        }
    }
    var locationManager: CLLocationManager!
    var currentLocation: CLLocationCoordinate2D?
    
    // MARK: - RETURN VALUES
    
    // MARK: - VOID METHODS
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            switch identifier {
            case "show detailed donation":
                guard
                    let cell = sender as? UITableViewCell,
                    let indexPath = postTable.indexPath(for: cell),
                    let vc = segue.destination as? ItemDetailViewController else {
                        fatalError("storyboard not set up correctly")
                }
                
                let selectedDonation = openDonations[indexPath.row]
                vc.donation = selectedDonation
            default: break
            }
        }
    }
    
    // MARK: - IBACTIONS
    @IBOutlet weak var postTable: UITableView!
    
    // MARK: - LIFE CYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager = CLLocationManager()
        locationManager.requestWhenInUseAuthorization()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        DonationService.showTimelineDonations { [weak self] (donations) in
            self?.openDonations = donations
        }
    }

}

extension ItemListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return openDonations.count //return number of posts
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let postCell = postTable.dequeueReusableCell(withIdentifier: "postCell") as! ItemPostCell
        
        let donation = openDonations[indexPath.row]
        postCell.itemName.text = donation.title
        
        postCell.itemImage.kf.setImage(with: URL(string: donation.imageUrl)!)
        postCell.postInfo.text = "@\(donation.donator.username)"
        
        let distanceTitle = UserService.calculateDistance(long: donation.longitude, lat: donation.laditude)
        postCell.distance.text = distanceTitle
        
        return postCell
    }
}

extension ItemListViewController: UITableViewDelegate {
    
}




