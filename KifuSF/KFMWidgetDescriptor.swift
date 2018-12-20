//
//  KFMWidgetDescriptor.swift
//  KifuSF
//
//  Created by Erick Sanchez on 10/5/18.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import Foundation

struct KFMWidgetDescriptor {
    
    struct Descriptor: KFPWidgetInfo {
        let title: String
        let subtitle: String
    }
    
    // MARK: - VARS
    
    private let donation: Donation
    
    init(for donation: Donation) {
        self.donation = donation
    }
    
    // MARK: - RETURN VALUES
    
    func forDonator() -> Descriptor {
        return Descriptor(
            title: donation.title,
            subtitle: donation.status.stringValueForDonator
        )
    }
    
    func forVolunteer() -> Descriptor {
        return Descriptor(
            title: donation.title,
            subtitle: donation.status.stringValueForVolunteer
        )
    }
    
    // MARK: - METHODS
}
