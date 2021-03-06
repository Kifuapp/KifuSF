//
//  UserDistance.swift
//  KifuSF
//
//  Created by Erick Sanchez on 12/22/18.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import Foundation

//TODO: use MeasurementFormatter
struct UserDistance: CustomStringConvertible {
    
    static func available(meters: Double) -> UserDistance {
        return UserDistance(meters: meters)
    }
    
    static func notAvailable() -> UserDistance {
        return UserDistance(meters: nil)
    }
    
    var isAvailable: Bool {
        return self.distance != nil
    }
    
    /** returns a user friendly string of the user's location */
    var description: String {
        guard let distance = self.distance else {
            return "Distance is not available"
        }
        
        let unit = Locale.current.usesMetricSystem ? "meters" : "miles"
        
        return "\(distance) \(unit) away from your current location"
    }
    
    private let distance: String?
    
    init(meters: Double?) {
        if let meters = meters {
            /**
             -distance(from: ...) returns in meters and 1609.344 converts it to miles
             */
            
            if Locale.current.usesMetricSystem {
                distance = String(format: "%.2f", meters)
            } else {
                //TODO: handle the error better; currently the formatter returns
                //the unit.symbol when it can't format
//                let formatter = MeasurementFormatter()
//                let userMeasurement = UnitLength.miles
//
//                distance = formatter.string(from: userMeasurement)
                
                distance = String(format: "%.2f", meters / 1609.344)
            }
        } else {
            distance = nil
        }
    }
}
