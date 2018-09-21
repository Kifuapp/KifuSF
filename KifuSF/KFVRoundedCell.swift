//
//  KFVRoundedCell.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 09/09/2018.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import UIKit

class KFVRoundedCell<T: KFVDescriptor>: UITableViewCell {
    let descriptorView = T()
    
    static var identifier: String {
        return String(describing: T.self)
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(descriptorView)
        
        translatesAutoresizingMaskIntoConstraints = false
        descriptorView.translatesAutoresizingMaskIntoConstraints = false
        
        descriptorView.autoPinEdge(toSuperviewEdge: .top, withInset: 8)
        descriptorView.autoPinEdge(toSuperviewEdge: .leading, withInset: 24)
        descriptorView.autoPinEdge(toSuperviewEdge: .trailing, withInset: 24)
        descriptorView.autoPinEdge(toSuperviewEdge: .bottom, withInset: 8)
        
        self.selectionStyle = .none
        layer.masksToBounds = false
        contentView.backgroundColor = UIColor.kfGray
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        descriptorView.backgroundColor = selected ? .kfHighlight : .kfWhite
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        
        descriptorView.backgroundColor = highlighted ? .kfHighlight : .kfWhite
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
