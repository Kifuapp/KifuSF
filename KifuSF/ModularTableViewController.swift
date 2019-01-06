//
//  KFCModularTableView.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 17/09/2018.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import UIKit

class ModularTableViewController: UIViewController, UIConfigurable {
    // MARK: - Variables
    enum CellTypes {
        case openDonationDescription
        case progress
        case entityInfo
        case inProgressDonationDescription
        case collaboratorInfo
        case destinationMap
    }

    let modularTableView = UITableView()
    var items = [ModularTableViewItem]()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        configureDelegates()
        configureStyling()
        configureLayout()
        configureData()

        reloadData()
    }

    // MARK: - Methods
    func reloadData() {
        items = [ModularTableViewItem]()

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

    func retrieveOpenDonationDescriptionItem() -> ModularTableViewItem? { return nil }
    func retrieveInProgressDonationDescription() -> ModularTableViewItem? { return nil }
    func retrieveProgressItem() -> ModularTableViewItem? { return nil }
    func retrieveEntityInfoItem() -> ModularTableViewItem? { return nil }
    func retrieveCollaboratorInfoItem() -> ModularTableViewItem? { return nil }
    func retrieveDestinationMapItem() -> ModularTableViewItem? { return nil }
    
    func didSelect(_ cellType: CellTypes, at indexPath: IndexPath) { }

    // MARK: - UIConfigurable
    func configureStyling() {
        modularTableView.allowsSelection = true
        modularTableView.contentInset.top = 0
        modularTableView.scrollIndicatorInsets.top = 0
        modularTableView.backgroundColor = UIColor.Pallete.White
    }

    func configureLayout() {
        view.addSubview(modularTableView)
        modularTableView.translatesAutoresizingMaskIntoConstraints = false
        modularTableView.autoPinEdgesToSuperviewEdges()
    }

    func configureDelegates() {
        modularTableView.dataSource = self
        modularTableView.delegate = self

        modularTableView.register(
            ModularTableViewCell<OpenDonationDetailedDescriptorView>.self,
            forCellReuseIdentifier: ModularTableViewCell<OpenDonationDetailedDescriptorView>.identifier
        )
        modularTableView.register(
            ModularTableViewCell<KFVInProgressDonationDescription>.self,
            forCellReuseIdentifier: ModularTableViewCell<KFVInProgressDonationDescription>.identifier
        )
        modularTableView.register(
            ModularTableViewCell<KFVEntityInfo>.self,
            forCellReuseIdentifier: ModularTableViewCell<KFVEntityInfo>.identifier
        )
        modularTableView.register(
            ModularTableViewCell<CollaboratorDescriptorView>.self,
            forCellReuseIdentifier: ModularTableViewCell<CollaboratorDescriptorView>.identifier
        )
        modularTableView.register(
            ModularTableViewCell<KFVDestinationMap>.self,
            forCellReuseIdentifier: ModularTableViewCell<KFVDestinationMap>.identifier
        )
        modularTableView.register(
            UINib(nibName: "KFVProgress",bundle: nil),
            forCellReuseIdentifier: "KFVProgress"
        )
    }

    func configureData() { }
}

// MARK: - UITableViewDataSource
extension ModularTableViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        if items.isEmpty {
            tableView.separatorStyle = .none

            let slideView = SlideView(image: .kfNoDataIcon,
                                      title: "No Data",
                                      description: "Go to...")
            tableView.backgroundView = slideView

            slideView.frame = CGRect(x: tableView.frame.width, y: 0,
                                     width: tableView.frame.width, height: tableView.frame.height)
//            slideView.translatesAutoresizingMaskIntoConstraints = false
//            slideView.autoCenterInSuperview()
//            slideView.autoPinEdgesToSuperviewMargins()
        } else {
            tableView.separatorStyle = .singleLine
            tableView.backgroundView = nil
        }

        return items.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items[section].rowCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.section]

        switch item.type {
        case .openDonationDescription:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ModularTableViewCell<OpenDonationDetailedDescriptorView>.identifier,
                                                           for: indexPath) as? ModularTableViewCell<OpenDonationDetailedDescriptorView>,
                let castedItem = item as? KFMOpenDonationDescriptionItem else {
                fatalError(KFErrorMessage.unknownCell)
            }

            cell.descriptorView.reloadData(for: castedItem)
            return cell

        case .inProgressDonationDescription:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ModularTableViewCell<KFVInProgressDonationDescription>.identifier,
                                                           for: indexPath) as? ModularTableViewCell<KFVInProgressDonationDescription>,
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
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ModularTableViewCell<KFVEntityInfo>.identifier,
                                                           for: indexPath) as? ModularTableViewCell<KFVEntityInfo>,
                let castedItem = item as? KFMEntityInfo else {
                    fatalError(KFErrorMessage.unknownCell)
            }

            cell.descriptorView.reloadData(for: castedItem)
            return cell

        case .collaboratorInfo:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ModularTableViewCell<CollaboratorDescriptorView>.identifier,
                                                           for: indexPath) as? ModularTableViewCell<CollaboratorDescriptorView>,
                let castedItem = item as? KFMCollaboratorInfo else {
                    fatalError(KFErrorMessage.unknownCell)
            }

            cell.descriptorView.reloadData(for: castedItem)
            return cell

        case .destinationMap:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ModularTableViewCell<KFVDestinationMap>.identifier,
                                                           for: indexPath) as? ModularTableViewCell<KFVDestinationMap>,
                let castedItem = item as? KFMDestinationMap else {
                    fatalError(KFErrorMessage.unknownCell)
            }
          
            cell.descriptorView.reloadData(for: castedItem.coordinate)
            cell.descriptorView.isUserInteractionEnabled = false
          
            return cell
        }
    }
}

// MARK: - UITableViewDelegate
extension ModularTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellType = items[indexPath.section].type
        self.didSelect(cellType, at: indexPath)
    }
}
