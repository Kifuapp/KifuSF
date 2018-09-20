//
//  KFVModularCell.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 17/09/2018.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import UIKit

class KFVModularCell<T: UIView>: UITableViewCell {
    let descriptorView = T()
    
    static var identifier: String {
        return String(describing: T.self)
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(descriptorView)
        contentView.backgroundColor = .kfWhite
        
        translatesAutoresizingMaskIntoConstraints = false
        descriptorView.translatesAutoresizingMaskIntoConstraints = false
        
        descriptorView.autoPinEdge(toSuperviewEdge: .top, withInset: 8)
        descriptorView.autoPinEdge(toSuperviewEdge: .leading, withInset: 8)
        descriptorView.autoPinEdge(toSuperviewEdge: .trailing, withInset: 8)
        descriptorView.autoPinEdge(toSuperviewEdge: .bottom, withInset: 8)
        
        self.selectionStyle = .none
        layer.masksToBounds = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

