//
//  UniversalExtensions+Date.swift
//  KifuSF
//
//  Created by Erick Sanchez on 1/4/19.
//  Copyright © 2019 Alexandru Turcanu. All rights reserved.
//

import Foundation

extension Date {
    /**
     Using `DateFormatter.localizedString`, format the receiver into a readable string.
     The default is Mar 30, 2018
     
     ### Example inputs
     0 is .none, 1 is .short, 2 is .medium, 3 is .long, 4 is .full
     d: 0 t: 0 ->
     d: 0 t: 1 -> 10:09 AM
     d: 0 t: 2 -> 10:09:00 AM
     d: 0 t: 3 -> 10:09:00 AM PDT
     d: 0 t: 4 -> 10:09:00 AM Pacific Daylight Time
     d: 1 t: 0 -> 3/30/18
     d: 1 t: 1 -> 3/30/18, 10:09 AM
     d: 1 t: 2 -> 3/30/18, 10:09:00 AM
     d: 1 t: 3 -> 3/30/18, 10:09:00 AM PDT
     d: 1 t: 4 -> 3/30/18, 10:09:00 AM Pacific Daylight Time
     d: 2 t: 0 -> Mar 30, 2018
     d: 2 t: 1 -> Mar 30, 2018 at 10:09 AM
     d: 2 t: 2 -> Mar 30, 2018 at 10:09:00 AM
     d: 2 t: 3 -> Mar 30, 2018 at 10:09:00 AM PDT
     d: 2 t: 4 -> Mar 30, 2018 at 10:09:00 AM Pacific Daylight Time
     d: 3 t: 0 -> March 30, 2018
     d: 3 t: 1 -> March 30, 2018 at 10:09 AM
     d: 3 t: 2 -> March 30, 2018 at 10:09:00 AM
     d: 3 t: 3 -> March 30, 2018 at 10:09:00 AM PDT
     d: 3 t: 4 -> March 30, 2018 at 10:09:00 AM Pacific Daylight Time
     d: 4 t: 0 -> Friday, March 30, 2018
     d: 4 t: 1 -> Friday, March 30, 2018 at 10:09 AM
     d: 4 t: 2 -> Friday, March 30, 2018 at 10:09:00 AM
     d: 4 t: 3 -> Friday, March 30, 2018 at 10:09:00 AM PDT
     d: 4 t: 4 -> Friday, March 30, 2018 at 10:09:00 AM Pacific Daylight Time
     */
    func stringValue(dateStyle: DateFormatter.Style = .medium, timeStyle: DateFormatter.Style = .none) -> String {
        return .init(DateFormatter.localizedString(from: self, dateStyle: dateStyle, timeStyle: timeStyle))
    }
}
