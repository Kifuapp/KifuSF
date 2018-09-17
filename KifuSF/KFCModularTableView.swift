//
//  KFCModularTableView.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 17/09/2018.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import UIKit

class KFCModularTableView: UIViewController {
    
    enum CellTypes { // view model
        case donationDescription, donationSteps, deliverySteps, entityInfo, destinationMap
    }
    
    let tableView = UITableView()
    var items = [KFPModularTableViewItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundColor = UIColor.kfWhite
        
        tableView.dataSource = self
        tableView.register(KFVModularCell<KFVDonationDescription>.self,
                           forCellReuseIdentifier: KFVModularCell<KFVDonationDescription>.identifier)
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.autoPinEdgesToSuperviewEdges()
        
        reloadData()
    }
    
    func reloadData() {
        items = [KFPModularTableViewItem]()
        
        if let donationDescriptionItem = retrieveDonationDescriptionItem() {
            items.append(donationDescriptionItem)
        }
    }
    
    func retrieveDonationDescriptionItem() -> KFPModularTableViewItem? {
        return KFVMDonationDescriptionItem(donationTitle: "Toilet Paper", username: "Pondorasti", creationDate: "12.12.12", userReputation: 79, userDonationsCount: 12, userDeliveriesCount: 12, distance: 2.4, description: "woof woof")
    }
}

extension KFCModularTableView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items[section].rowCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.section]
        
        switch item.type {
        case .donationDescription:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: KFVModularCell<KFVDonationDescription>.identifier,
                                                           for: indexPath) as? KFVModularCell<KFVDonationDescription>,
                let castedItem = item as? KFVMDonationDescriptionItem else {
                fatalError(KFErrorMessage.unknownCell)
            }
            
            cell.descriptorView.update(for: castedItem)
            return cell
            
        default:
            fatalError(KFErrorMessage.unknownCell)
        }
    }
}

protocol KFPModularTableViewItem {
    var type: KFCModularTableView.CellTypes { get }
    var sectionTitle: String { get }
    var rowCount: Int { get }
}

extension KFPModularTableViewItem {
    var sectionTitle: String {
        return "Not aplicable"
    }
    
    var rowCount: Int {
        return 1
    }
}
