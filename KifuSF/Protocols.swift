//
//  Protocols.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 02/10/2018.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import Foundation

protocol UIConfigurable {
    func configureStyling()
    func configureLayoutConstraints()
    func configureGestures()
}

extension UIConfigurable {
    func configureStyling() { }
    func configureLayoutConstraints() { }
    func configureGestures() { }
}
