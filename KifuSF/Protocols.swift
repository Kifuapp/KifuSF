//
//  Protocols.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 02/10/2018.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import Foundation

protocol UIConfigurable {
    /**
     Poof
     */
    func configureStyling()
    func configureLayout()
    func configureGestures()
    func configureDelegates()
}

extension UIConfigurable {
    func configureStyling() { }
    func configureLayout() { }
    func configureGestures() { }
    func configureDelegates() { }
}
