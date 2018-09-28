//
//  KFMEntityInfo.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 28/09/2018.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import Foundation

class KFMEntityInfo: KFPModularTableViewItem {
    var type: KFCModularTableView.CellTypes = .entityInfo
    
    enum EntityType: String {
        case charity, donator, deliverer
    }
    
    var name: String
    var phoneNumber: String
    var address: String
    var entityType: EntityType
    
    init(name: String, phoneNumber: String, address: String, entityType: EntityType) {
        self.name = name
        self.phoneNumber = phoneNumber
        self.address = address
        self.entityType = entityType
    }
}
