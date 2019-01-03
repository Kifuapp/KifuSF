//
//  URL.swift
//  KifuSF
//
//  Created by Erick Sanchez on 10/12/18.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import Foundation

extension URL {
    static let brokenUrlImage: URL = URL(string: "https://d30y9cdsu7xlg0.cloudfront.net/png/11788-200.png")!

    enum Websites: String {
        case stAnthony = "https://github.com/apple/swift/blob/master/docs/ABIStabilityManifesto.md"

    }

    init?(website: Websites) {
        self.init(string: website.rawValue)
    }
}
