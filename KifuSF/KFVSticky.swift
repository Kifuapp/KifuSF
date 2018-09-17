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
    var offset: CGFloat?
    
    let contentView = T()
    var anchors = [NSLayoutConstraint]()
    
    override init(frame: CGRect) {
        stickySide = nil
        offset = nil
        
        super.init(frame: frame)
        addSubview(contentView)
        setupLayoutConstraints()
    }
    
    convenience init(stickySide: ALEdge) {
        self.init(stickySide: stickySide, withOffset: nil)
    }
    
    init(stickySide: ALEdge, withOffset offset: CGFloat?) {
        self.stickySide = stickySide
        self.offset = offset
        
        super.init(frame: UIScreen.main.bounds)
        addSubview(contentView)
        setupLayoutConstraints()
    }
    
    func setupLayoutConstraints() {
        translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        let offset = self.offset ?? 0
        
        anchors = [
        contentView.autoPinEdge(toSuperviewEdge: .top,
                                withInset: (stickySide == .top) ? offset : 0,
                                relation: (stickySide?.opositeSide() == .top) ? .greaterThanOrEqual : .equal),
        contentView.autoPinEdge(toSuperviewEdge: .leading,
                                withInset: (stickySide == .leading) ? offset : 0,
                                relation: (stickySide?.opositeSide() == .leading) ? .greaterThanOrEqual : .equal),
        contentView.autoPinEdge(toSuperviewEdge: .trailing,
                                withInset: (stickySide == .trailing) ? offset : 0,
                                relation: (stickySide?.opositeSide() == .trailing) ? .greaterThanOrEqual : .equal),
        contentView.autoPinEdge(toSuperviewEdge: .bottom,
                                withInset: (stickySide == .bottom) ? offset : 0,
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
