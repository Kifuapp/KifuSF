//
//  MapHelper.swift
//  KifuSF
//
//  Created by Erick Sanchez on 8/18/18.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import UIKit
import MapKit

struct MapHelper {
    let long: Double
    let lat: Double
    
    func open() {
        let url = "http://maps.apple.com/maps?saddr=&daddr=\(self.long),\(self.lat)"
        UIApplication.shared.open(URL(string: url)!, options: [:], completionHandler: nil)
    }
}
