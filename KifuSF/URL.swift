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
        case termsOfService = "https://docs.google.com/document/d/e/2PACX-1vRRbR91VeL6B_jyFlHWvTwMw815PzWCxACZWi2eFQCBr_fyyAALtBYx-xH_fkw2Saa0VXzEDYEWxA9E/pub"
        case privacyPolicy = "https://docs.google.com/document/d/1GVi6VecrJ1u1LZCbRyA2JlQCxJV0PnLlQ__rJeZmYHs/edit"

    }

    init?(website: Websites) {
        self.init(string: website.rawValue)
    }
}
