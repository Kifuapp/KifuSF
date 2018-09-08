//
//  KFVSticky.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 07/09/2018.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import UIKit
import PureLayout

class KFVSticky<T: UIView>: UIView {
    
    var stickySide: ALEdge?
    let contentView = T()
    var anchors = [NSLayoutConstraint]()
    
    override init(frame: CGRect) {
        stickySide = nil
        
        super.init(frame: frame)
        addSubview(contentView)
        setupLayoutConstraints()
    }
    
    init(stickySide: ALEdge) {
        self.stickySide = stickySide
        
        super.init(frame: UIScreen.main.bounds)
        addSubview(contentView)
        setupLayoutConstraints()
    }
    
    func setupLayoutConstraints() {
        translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        anchors = [
        contentView.autoPinEdge(toSuperviewEdge: .top,
                                withInset: 0,
                                relation: (stickySide?.opositeSide() == .top) ? .greaterThanOrEqual : .equal),
        contentView.autoPinEdge(toSuperviewEdge: .leading,
                                withInset: 0,
                                relation: (stickySide?.opositeSide() == .leading) ? .greaterThanOrEqual : .equal),
        contentView.autoPinEdge(toSuperviewEdge: .trailing,
                                withInset: 0,
                                relation: (stickySide?.opositeSide() == .trailing) ? .greaterThanOrEqual : .equal),
        contentView.autoPinEdge(toSuperviewEdge: .bottom,
                                withInset: 0,
                                relation: (stickySide?.opositeSide() == .bottom) ? .greaterThanOrEqual : .equal)
        ]
    }
    
    func updateStickySide(to side: ALEdge? = nil) {
        self.stickySide = side
        
        NSLayoutConstraint.deactivate(anchors)
        setupLayoutConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: I have no idea who wrote this code 🤷‍♂️... definitly not me 🤥
    //FIXED: removed the ugly function, no need for somebody else to see it
}

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
