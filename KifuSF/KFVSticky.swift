//
//  KFVSticky.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 07/09/2018.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import UIKit
import PureLayout

class KFVSticky<T: UIView>: UIView, Configurable {
    
    private(set) var stickySide: ALEdge?
    
    private var _offset: CGFloat?
    
    var offset: CGFloat {
        get {
            return _offset ?? 0
        }
        
        set {
            _offset = newValue
        }
    }
    
    let contentView = T()
    var layoutConstraints = [NSLayoutConstraint]()
    
    override init(frame: CGRect) {
        stickySide = nil
        _offset = nil
        
        super.init(frame: frame)
        addSubview(contentView)
        configureLayoutConstraints()
    }
    
    convenience init(stickySide: ALEdge) {
        self.init(stickySide: stickySide, withOffset: nil)
    }
    
    init(stickySide: ALEdge, withOffset offset: CGFloat?) {
        self.stickySide = stickySide
        self._offset = offset
        
        super.init(frame: UIScreen.main.bounds)
        addSubview(contentView)
        configureLayoutConstraints()
    }
    
    func configureLayoutConstraints() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        layoutConstraints = [
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
        
        NSLayoutConstraint.deactivate(layoutConstraints)
        configureLayoutConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: I have no idea who wrote this code 🤷‍♂️... definitly not me 🤥
    //FIXED: removed the ugly function, no need for somebody else to see it
}
