//
//  KFVModularCell.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 17/09/2018.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import UIKit

class KFVModularCell<T: KFVDescriptor>: UITableViewCell {
    let descriptorView = T()
    
    static var identifier: String {
        return String(describing: T.self)
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(descriptorView)
        
        translatesAutoresizingMaskIntoConstraints = false
        descriptorView.translatesAutoresizingMaskIntoConstraints = false
        
        descriptorView.autoPinEdgesToSuperviewEdges()
        
        self.selectionStyle = .none
        layer.masksToBounds = false
        contentView.backgroundColor = UIColor.kfGray
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

