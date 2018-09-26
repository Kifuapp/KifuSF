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
        case openDonationDescription, progress // done
        case inProgressDonationDescription, entityInfo, destinationMap
    }
    
    let tableView = UITableView()
    var items = [KFPModularTableViewItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.allowsSelection = false
        tableView.backgroundColor = UIColor.kfWhite
        
        tableView.dataSource = self
        tableView.register(KFVModularCell<KFVOpenDonationDescription>.self,
                           forCellReuseIdentifier: KFVModularCell<KFVOpenDonationDescription>.identifier)
        tableView.register(KFVModularCell<KFVInProgressDonationDescription>.self,
                           forCellReuseIdentifier: KFVModularCell<KFVInProgressDonationDescription>.identifier)
        
        tableView.register(UINib(nibName: "KFVProgress", bundle: nil), forCellReuseIdentifier: "KFVProgress")
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.autoPinEdgesToSuperviewEdges()
        
        reloadData()
    }
    
    func reloadData() {
        items = [KFPModularTableViewItem]()
        
        if let openDonationDescriptionItem = retrieveOpenDonationDescriptionItem() {
            items.append(openDonationDescriptionItem)
        }
        
        if let inProgressDonationDescriptionItem = retrieveInProgressDonationDescription() {
            items.append(inProgressDonationDescriptionItem)
        }
        
        if let progressItem = retrieveProgressItem() {
            items.append(progressItem)
        }
        
        tableView.reloadData()
    }
    
    func retrieveOpenDonationDescriptionItem() -> KFPModularTableViewItem? {
        return nil
    }
    
    func retrieveInProgressDonationDescription() -> KFPModularTableViewItem? {
        return nil
    }
    
    func retrieveProgressItem() -> KFPModularTableViewItem? {
        return nil
    }
    
    func retrieveEntityInfoItem() -> KFPModularTableViewItem? {
        return nil
    }
    
    func retrieveDestinationMapItem() -> KFPModularTableViewItem? {
        return nil
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
        case .openDonationDescription:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: KFVModularCell<KFVOpenDonationDescription>.identifier,
                                                           for: indexPath) as? KFVModularCell<KFVOpenDonationDescription>,
                let castedItem = item as? KFMOpenDonationDescriptionItem else {
                fatalError(KFErrorMessage.unknownCell)
            }
            
            cell.descriptorView.reloadData(for: castedItem)
            return cell
            
        case .inProgressDonationDescription:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: KFVModularCell<KFVInProgressDonationDescription>.identifier,
                                                           for: indexPath) as? KFVModularCell<KFVInProgressDonationDescription>,
                let castedItem = item as? KFMInProgressDonationDescription else {
                    fatalError(KFErrorMessage.unknownCell)
            }
            
            cell.descriptorView.reloadData(for: castedItem)
            return cell
            
        case .progress:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "KFVProgress", for: indexPath) as? KFVProgress,
                let castedItem = item as? KFMProgress else {
                fatalError(KFErrorMessage.unknownCell)
            }
            
            cell.reloadData(for: castedItem)
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
