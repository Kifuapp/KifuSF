//
//  URL.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 03/01/2019.
//  Copyright © 2019 Alexandru Turcanu. All rights reserved.
//

import UIKit

extension URL {
    enum Websites: String {
        case stAnthony = "https://github.com/apple/swift/blob/master/docs/ABIStabilityManifesto.md"

    }

    init?(website: Websites) {
        self.init(string: website.rawValue)
    }
}
