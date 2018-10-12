//
//  KFCModularTableView.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 17/09/2018.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import UIKit

class KFCModularTableView: UIViewController {

    enum CellTypes {
        case openDonationDescription, progress, entityInfo, inProgressDonationDescription, collaboratorInfo, destinationMap // done
    }

    let modularTableView = UITableView()
    var modularTableViewConstraints = [NSLayoutConstraint]()
    var items = [KFPModularTableViewItem]()

    override func loadView() {
        super.loadView()

        view.addSubview(modularTableView)
        modularTableView.translatesAutoresizingMaskIntoConstraints = false
        modularTableViewConstraints = modularTableView.autoPinEdgesToSuperviewEdges()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        modularTableView.allowsSelection = false
        modularTableView.backgroundColor = UIColor.kfSuperWhite
        modularTableView.contentInset.top = 0
        modularTableView.scrollIndicatorInsets.top = 0

        modularTableView.dataSource = self
        modularTableView.register(KFVModularCell<KFVOpenDonationDescription>.self,
                           forCellReuseIdentifier: KFVModularCell<KFVOpenDonationDescription>.identifier)
        modularTableView.register(KFVModularCell<KFVInProgressDonationDescription>.self,
                           forCellReuseIdentifier: KFVModularCell<KFVInProgressDonationDescription>.identifier)
        modularTableView.register(KFVModularCell<KFVEntityInfo>.self,
                           forCellReuseIdentifier: KFVModularCell<KFVEntityInfo>.identifier)
        modularTableView.register(KFVModularCell<KFVCollaboratorInfo>.self,
                           forCellReuseIdentifier: KFVModularCell<KFVCollaboratorInfo>.identifier)
        modularTableView.register(KFVModularCell<KFVDestinationMap>.self,
                           forCellReuseIdentifier: KFVModularCell<KFVDestinationMap>.identifier)

        modularTableView.register(UINib(nibName: "KFVProgress", bundle: nil), forCellReuseIdentifier: "KFVProgress")

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

        if let entityInfoItem = retrieveEntityInfoItem() {
            items.append(entityInfoItem)
        }

        if let collaboratorInfoItem = retrieveCollaboratorInfoItem() {
            items.append(collaboratorInfoItem)
        }

        if let destinationMapItem = retrieveDestinationMapItem() {
            items.append(destinationMapItem)
        }

        modularTableView.reloadData()
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

    func retrieveCollaboratorInfoItem() -> KFPModularTableViewItem? {
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

        case .entityInfo:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: KFVModularCell<KFVEntityInfo>.identifier,
                                                           for: indexPath) as? KFVModularCell<KFVEntityInfo>,
                let castedItem = item as? KFMEntityInfo else {
                    fatalError(KFErrorMessage.unknownCell)
            }

            cell.descriptorView.reloadData(for: castedItem)
            return cell

        case .collaboratorInfo:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: KFVModularCell<KFVCollaboratorInfo>.identifier,
                                                           for: indexPath) as? KFVModularCell<KFVCollaboratorInfo>,
                let castedItem = item as? KFMCollaboratorInfo else {
                    fatalError(KFErrorMessage.unknownCell)
            }

            cell.descriptorView.reloadData(for: castedItem)
            return cell

        case .destinationMap:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: KFVModularCell<KFVDestinationMap>.identifier,
                                                           for: indexPath) as? KFVModularCell<KFVDestinationMap>,
                let castedItem = item as? KFMDestinationMap else {
                    fatalError(KFErrorMessage.unknownCell)
            }


            return cell
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
