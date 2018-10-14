//
//  Protocols.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 02/10/2018.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import Foundation

protocol Configurable {
    func configureStyling()
    func configureLayoutConstraints()
    func configureGestures()
}

extension Configurable {
    func configureStyling() { }
    func configureLayoutConstraints() { }
    func configureGestures() { }
}
