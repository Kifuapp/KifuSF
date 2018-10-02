//
//  KFMEntityInfo.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 28/09/2018.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import Foundation

class KFMEntityInfo: KFPModularTableViewItem {
    let type: KFCModularTableView.CellTypes = .entityInfo
    
    enum EntityType: String {
        case charity, donator, deliverer
    }
    
    let name: String
    let phoneNumber: String
    let address: String
    let entityType: EntityType
    
    init(name: String, phoneNumber: String, address: String, entityType: EntityType) {
        self.name = name
        self.phoneNumber = phoneNumber
        self.address = address
        self.entityType = entityType
    }
}
