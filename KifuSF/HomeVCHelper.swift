//
//  HomeVCHelper.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 28/08/2018.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import Foundation
import UIKit

extension HomeViewController {
    
    func setUpWidgetView() {
        guard let widgetView = Bundle.main.loadNibNamed(KFWidgetView.nibName, owner: self, options: nil)?.first as? KFWidgetView else {
            assertionFailure("could not load widget view")
            return
        }
        
        view.addSubview(widgetView)
        
        widgetView.translatesAutoresizingMaskIntoConstraints = false
        
        widgetView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        widgetView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        widgetView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
    }
    
    func setUpDonationTableView() {
        donationsTableView.dataSource = self
        donationsTableView.delegate = self
        
        donationsTableView.separatorStyle = .none
        
        let donationTableViewCell = UINib(nibName: KFDonationTableViewCell.nibName, bundle: nil)
        donationsTableView.register(donationTableViewCell, forCellReuseIdentifier: KFDonationTableViewCell.reuseIdentifier)
    }
    
    func setUpNavBar() {
        navigationController?.tabBarItem.image = UIImage(named: "BoxIcon")
        navigationController?.tabBarItem.title = "Home"
        navigationController?.navigationItem.title = "Donations"
        
        //MARK: Some random attempt to create the same blur effect between widget view and nav bar
        
//        self.navigationController?.navigationBar.isTranslucent = true
//        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
//
//        var bounds = navigationController!.navigationBar.bounds
//        bounds.size.height += 20
//        bounds.origin.y -= 20
//
//        let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .light))
//        visualEffectView.isUserInteractionEnabled = false
//        visualEffectView.frame = bounds
//        visualEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//
//        self.navigationController?.navigationBar.addSubview(visualEffectView)
//        visualEffectView.layer.zPosition = -1
    }
}
