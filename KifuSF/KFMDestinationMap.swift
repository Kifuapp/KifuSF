//
//  KFMDestinationMap.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 01/10/2018.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import Foundation
import CoreLocation

class KFMDestinationMap: KFPModularTableViewItem {
    let type: KFCModularTableView.CellTypes = .destinationMap
    
    let coordinate: CLLocationCoordinate2D
    
    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
    }
}
