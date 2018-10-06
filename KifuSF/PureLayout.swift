//
//  PureLayout.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 02/10/2018.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import PureLayout

extension ALEdge {
    func opositeSide() -> ALEdge {
        switch self {
        case .bottom:
            return .top
        case .top:
            return .bottom
        case .trailing:
            return .leading
        case .leading:
            return .trailing
        case .left:
            return .right
        case .right:
            return .left
        }
    }
}
