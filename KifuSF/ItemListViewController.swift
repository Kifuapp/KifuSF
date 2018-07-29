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
    
    
    @IBOutlet weak var postTable: UITableView!
    
    var locationManager: CLLocationManager!
    var currentLocation: CLLocationCoordinate2D?
    
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
        
        //TODO: Backend-calc the distance from current user to the donation long/lat
        postCell.itemImage.kf.setImage(with: URL(string: donation.imageUrl)!)
        postCell.distance.text = "\(1.0) miles from here"
        postCell.postInfo.text = "@\(donation.donator.username)"
        
        UserService.calculateDistance(from: CLLocation(latitude: donation.laditude, longitude: donation.longitude), completion: { (response) in
            postCell.distance.text = response
        })
        
        return postCell
    }
}

extension ItemListViewController: UITableViewDelegate {
    
}




